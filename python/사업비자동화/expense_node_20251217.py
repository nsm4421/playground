"""Abstract expense node that can represent arbitrary ordered fields."""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto
from typing import Any, Callable, Mapping, Sequence, Tuple


class NodeRelation(Enum):
    """Relationship between two nodes."""

    A_TO_B = auto()
    B_TO_A = auto()
    BIDIRECTIONAL = auto()
    DISCONNECTED = auto()


@dataclass(frozen=True)
class AbsExpenseNode:
    """Node with ordered fields; relation is resolved from the last field backwards."""

    fields: Tuple[str, ...]
    values: Tuple[Any, ...]

    @classmethod
    def from_mapping(cls, fields: Sequence[str], data: Mapping[str, Any]) -> "AbsExpenseNode":
        """Create a node ensuring all fields exist and preserve order."""
        missing = [f for f in fields if f not in data]
        if missing:
            raise KeyError(f"Missing fields: {missing}")
        return cls(tuple(fields), tuple(data[f] for f in fields))

    def to_dict(self) -> dict[str, Any]:
        """Return mapping of field names to values."""
        return dict(zip(self.fields, self.values))

    def relation_to(
        self,
        other: "AbsExpenseNode",
        comparators: Mapping[str, Callable[[Any, Any], bool]] | None = None,
    ) -> NodeRelation:
        """Determine relation via element-wise comparison.

        Rules (on fields included in comparators):
          - All fields equal -> BIDIRECTIONAL
          - If all self <= other -> A_TO_B
          - If all other <= self -> B_TO_A
          - Otherwise -> DISCONNECTED
          - Different field sets/order after filtering -> DISCONNECTED

        Fields not listed in comparators are ignored. If comparators is None, no comparison is made
        and the nodes are treated as disconnected.
        """
        if not isinstance(other, AbsExpenseNode):
            return NodeRelation.DISCONNECTED
        if comparators is None:
            return NodeRelation.DISCONNECTED

        filtered_fields = tuple(f for f in self.fields if f in comparators)
        other_filtered_fields = tuple(f for f in other.fields if f in comparators)
        if not filtered_fields:
            return NodeRelation.DISCONNECTED
        if filtered_fields != other_filtered_fields:
            return NodeRelation.DISCONNECTED

        filtered_values = tuple(v for f, v in zip(self.fields, self.values) if f in comparators)
        other_filtered_values = tuple(
            v for f, v in zip(other.fields, other.values) if f in comparators
        )

        if filtered_values == other_filtered_values:
            return NodeRelation.BIDIRECTIONAL

        def _le(field: str, a: Any, b: Any) -> bool:
            comp = comparators.get(field)
            if comp:
                return comp(a, b)
            return False

        eq_by_comparator = all(
            _le(f, a, b) and _le(f, b, a)
            for f, a, b in zip(filtered_fields, filtered_values, other_filtered_values)
        )
        if eq_by_comparator:
            return NodeRelation.BIDIRECTIONAL

        all_a_le_b = all(
            _le(f, a, b) for f, a, b in zip(filtered_fields, filtered_values, other_filtered_values)
        )
        all_b_le_a = all(
            _le(f, b, a) for f, a, b in zip(filtered_fields, filtered_values, other_filtered_values)
        )

        if all_a_le_b and not all_b_le_a:
            return NodeRelation.A_TO_B
        if all_b_le_a and not all_a_le_b:
            return NodeRelation.B_TO_A
        if all_a_le_b and all_b_le_a:
            # Should have been caught by equality check, but guard for equal values
            return NodeRelation.BIDIRECTIONAL

        return NodeRelation.DISCONNECTED


class TermGuardNode(AbsExpenseNode):
    """Concrete node to detect inversion between policy term and payment term."""

    def __init__(self, cov_seq: int, jong: int, hyung: int, pol_term: int, pay_term: int):
        fields = ("cov_seq", "jong", "hyung", "pol_term", "pay_term")
        values = (int(cov_seq), int(jong), int(hyung), int(pol_term), int(pay_term))
        object.__setattr__(self, "fields", fields)
        object.__setattr__(self, "values", values)

    @property
    def cov_seq(self) -> int:
        return int(self.values[0])

    @property
    def jong(self) -> int:
        return int(self.values[1])

    @property
    def hyung(self) -> int:
        return int(self.values[2])

    @property
    def pol_term(self) -> int:
        return int(self.values[3])

    @property
    def pay_term(self) -> int:
        return int(self.values[4])

    def has_inversion(self) -> bool:
        """Return True when pay_term exceeds pol_term (납기 > 만기)."""
        return self.pay_term > self.pol_term
