"""Streamlit demo that shows mock expense rows and visualizes node relations."""

from __future__ import annotations

from pathlib import Path
from typing import Tuple

import sys
import streamlit as st

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from src.expense_node import AbsExpenseNode, NodeRelation

FIELDS: Tuple[str, ...] = ("cov_seq", "jong", "hyung", "pol_term", "pay_term")
NAMES = {1: "뇌출혈진단비", 2: "뇌졸중진단비", 3:"뇌혈관진단비"}


def make_mock_rows() -> list[dict[str, object]]:
    """Return hard-coded mock expense rows (납입기간 = 보험기간)."""
    return [
        {"담보순번": 1, "담보명": NAMES[1], "종": "1", "형": "0", "보기": "20년", "납기": "20년", "a1": 10},
        {"담보순번": 1, "담보명": NAMES[1], "종": "1", "형": "0", "보기": "30년", "납기": "30년", "a1": 4},
        {"담보순번": 1, "담보명": NAMES[1], "종": "2", "형": "0", "보기": "20년", "납기": "20년", "a1": 8},
        {"담보순번": 1, "담보명": NAMES[1], "종": "2", "형": "0", "보기": "30년", "납기": "30년", "a1": 4},
        {"담보순번": 2, "담보명": NAMES[2], "종": "1", "형": "0", "보기": "20년", "납기": "20년", "a1": 5},
        {"담보순번": 2, "담보명": NAMES[2], "종": "1", "형": "0", "보기": "30년", "납기": "30년", "a1": 3},
        {"담보순번": 2, "담보명": NAMES[2], "종": "2", "형": "0", "보기": "20년", "납기": "20년", "a1": 4},
        {"담보순번": 2, "담보명": NAMES[2], "종": "2", "형": "0", "보기": "30년", "납기": "30년", "a1": 2},
        {"담보순번": 3, "담보명": NAMES[3], "종": "1", "형": "0", "보기": "20년", "납기": "20년", "a1": 5},
        {"담보순번": 3, "담보명": NAMES[3], "종": "1", "형": "0", "보기": "30년", "납기": "30년", "a1": 3},
        {"담보순번": 3, "담보명": NAMES[3], "종": "2", "형": "0", "보기": "20년", "납기": "20년", "a1": 4},
        {"담보순번": 3, "담보명": NAMES[3], "종": "2", "형": "0", "보기": "30년", "납기": "30년", "a1": 2},
    ]


def _normalize_term(value: object) -> int:
    """Extract numeric year from string like '10년'."""
    return int(str(value).replace("년", "").strip())


def row_to_node(row: dict[str, object]) -> AbsExpenseNode:
    """Convert a mock data row into AbsExpenseNode."""
    data = {
        "cov_seq": int(row["담보순번"]),
        "jong": int(row["종"]),
        "hyung": int(row["형"]),
        "pol_term": _normalize_term(row["보기"]),
        "pay_term": _normalize_term(row["납기"]),
    }
    return AbsExpenseNode.from_mapping(FIELDS, data)


def compute_edges(
    rows: list[dict[str, object]], nodes: list[AbsExpenseNode]
) -> list[tuple[int, int, NodeRelation]]:
    """Build directional edges based on NodeRelation."""
    comparators = {
        "cov_seq": lambda a, b: a == b,
        "jong": lambda a, b: a == b,
        "hyung": lambda a, b: a == b,
        "pol_term": lambda a, b: a <= b,
        "pay_term": lambda a, b: a <= b,
    }
    edges: list[tuple[int, int, NodeRelation]] = []
    for i in range(len(nodes)):
        for j in range(i + 1, len(nodes)):
            relation = nodes[i].relation_to(nodes[j], comparators=comparators)
            if relation == NodeRelation.A_TO_B:
                edges.append((i, j, relation))
            elif relation == NodeRelation.B_TO_A:
                edges.append((j, i, relation))
            elif relation == NodeRelation.BIDIRECTIONAL:
                edges.append((i, j, relation))
    return edges


def build_graph(rows: list[dict[str, object]], edges: list[tuple[int, int, NodeRelation]]) -> str:
    """Generate Graphviz DOT string for Streamlit."""
    lines: list[str] = [
        "digraph G {",
        '  rankdir=LR;',
        '  node [shape=plaintext, fontname="Helvetica", fontsize=8];',
        '  edge [color="#2563EB", penwidth=1.0];',
    ]
    lines.extend(_build_graph_section(rows, edges, prefix="n", cluster_label="그래프"))
    lines.append("}")
    return "\n".join(lines)


def _build_graph_section(
    rows: list[dict[str, object]],
    edges: list[tuple[int, int, NodeRelation]],
    prefix: str,
    cluster_label: str,
) -> list[str]:
    palette = {1: "#DBEAFE", 2: "#E0F2FE"}
    border = {1: "#2563EB", 2: "#0EA5E9"}
    edge_color = {
        NodeRelation.A_TO_B: "#2563EB",
        NodeRelation.B_TO_A: "#2563EB",
        NodeRelation.BIDIRECTIONAL: "#9333EA",
    }

    lines: list[str] = [
        f'  subgraph cluster_{prefix} {{',
        f'    label="{cluster_label}";',
        '    style="rounded";',
        '    color="#CBD5E1";',
    ]

    for idx, row in enumerate(rows):
        cov_seq = int(row["담보순번"])
        fill = palette.get(cov_seq, "#EEF2FF")
        stroke = border.get(cov_seq, "#4F46E5")
        label = (
            f'<'
            f'<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="3" '
            f'BGCOLOR="{fill}" COLOR="{stroke}">'
            f'<TR><TD><B>{row["담보순번"]}-{row["담보명"]}</B></TD></TR>'
            f'<TR><TD>종{row["종"]} 형{row["형"]}</TD></TR>'
            f'<TR><TD>{row["보기"]} / {row["납기"]}</TD></TR>'
            f'<TR><TD>a1={row["a1"]}</TD></TR>'
            f'</TABLE>'
            f'>'
        )
        lines.append(f'    {prefix}{idx} [label={label}];')

    for src, dst, relation in edges:
        if relation == NodeRelation.BIDIRECTIONAL:
            lines.append(
                f'    {prefix}{src} -> {prefix}{dst} [dir=both, color="{edge_color[relation]}", penwidth=1.6, label="BIDIR"];'
            )
        else:
            lines.append(
                f'    {prefix}{src} -> {prefix}{dst} [color="{edge_color.get(relation, "#2563EB")}"];'
            )

    lines.append("  }")
    return lines


def apply_constraints(
    rows: list[dict[str, object]],
    nodes: list[AbsExpenseNode],
    edges: list[tuple[int, int, NodeRelation]],
    constraints: list[dict[str, int | str]],
) -> list[tuple[int, int, NodeRelation]]:
    """Add user-specified inclusion relations between coverages using relation_to."""
    index_by_cov: dict[int, list[int]] = {}
    for idx, row in enumerate(rows):
        index_by_cov.setdefault(int(row["담보순번"]), []).append(idx)

    comparators = {
        "cov_seq": lambda a, b: a <= b,
        "jong": lambda a, b: a == b,
        "hyung": lambda a, b: a == b,
        "pol_term": lambda a, b: a <= b,
        "pay_term": lambda a, b: a <= b,
    }

    edges_set = set(edges)
    for constraint in constraints:
        left = int(constraint["left"])
        right = int(constraint["right"])
        if left not in index_by_cov or right not in index_by_cov:
            continue
        for li in index_by_cov[left]:
            for ri in index_by_cov[right]:
                relation = nodes[li].relation_to(nodes[ri], comparators=comparators)
                if relation == NodeRelation.A_TO_B:
                    edges_set.add((li, ri, relation))
                elif relation == NodeRelation.BIDIRECTIONAL:
                    edges_set.add((li, ri, relation))
    return list(edges_set)


def format_constraint(constraint: dict[str, int | str]) -> str:
    """Render a human-friendly inclusion relation."""
    left = int(constraint["left"])
    right = int(constraint["right"])
    op = str(constraint["op"])
    op_display = {"<": "<="}.get(op, op)
    return f"[{left}]{NAMES.get(left, '?')} {op_display} [{right}]{NAMES.get(right, '?')}"


def apply_expense_updates(
    rows: list[dict[str, object]], edges: list[tuple[int, int, NodeRelation]]
) -> tuple[list[dict[str, object]], int]:
    """Adjust a1 so that for every A_TO_B edge, a1(A) <= a1(B)."""
    new_rows = [dict(r) for r in rows]
    changes = 0

    def clamp(idx: int, target: int) -> None:
        nonlocal changes
        current = int(new_rows[idx]["a1"])
        if current > target:
            new_rows[idx]["a1"] = target
            changes += 1

    for src, dst, relation in edges:
        if relation == NodeRelation.A_TO_B:
            clamp(src, int(new_rows[dst]["a1"]))
        elif relation == NodeRelation.BIDIRECTIONAL:
            target = min(int(new_rows[src]["a1"]), int(new_rows[dst]["a1"]))
            clamp(src, target)
            clamp(dst, target)

    return new_rows, changes


def main() -> None:
    st.set_page_config(
        page_title="사업비 역전누르기 데모",
        page_icon="💸",
        layout="wide",
    )
    st.title("사업비 역전누르기 데모")
    st.write(
        "사업비 테이블의 각 라인은 하나의 세목이고, 세목(담보순번, 담보명, 종, 형, 보기, "
        "납기 등)을 하나의 노드로 봅니다. 세목 간 사업비 대소관계를 유향 그래프처럼 "
        "살피며 역전을 체크하고 누르는 기능을 만드는 것이 목표이고, 이를 위해 "
        "expense node와 expense value 모델을 정의했습니다. 아래는 담보순번 1~2, "
        "보기/납기 20·30년 조합으로 만든 중복 없는 모의 데이터입니다."
    )

    if "rows" not in st.session_state:
        st.session_state["rows"] = make_mock_rows()

    st.subheader("샘플 사업비 테이블 (mock)")
    rows = st.session_state["rows"]
    st.dataframe(rows, use_container_width=True, hide_index=True)

    st.divider()
    st.subheader("담보 포함 관계 입력")
    if "constraints" not in st.session_state:
        st.session_state["constraints"] = []

    with st.form("constraint_form", clear_on_submit=True):
        col1, col2, col3 = st.columns([2, 1, 2])
        left_choice = col1.selectbox(
            "Left (담보)",
            options=list(NAMES.keys()),
            format_func=lambda x: f"{x} - {NAMES[x]}",
        )
        with col2:
            st.markdown("**Operation**")
            op_choice = "<"
            st.caption("`<=` 만 사용")
        right_choice = col3.selectbox(
            "Right (담보)",
            options=list(NAMES.keys()),
            format_func=lambda x: f"{x} - {NAMES[x]}",
        )
        submitted = st.form_submit_button("추가하기")
        if submitted:
            st.session_state["constraints"].append(
                {"left": int(left_choice), "op": op_choice, "right": int(right_choice)}
            )

    if st.session_state["constraints"]:
        st.caption("입력된 포함 관계")
        to_remove: list[int] = []
        for idx, c in enumerate(st.session_state["constraints"]):
            col_text, col_btn = st.columns([10, 1])
            with col_text:
                st.write(format_constraint(c))
            with col_btn:
                if st.button("x", key=f"remove_constraint_{idx}"):
                    to_remove.append(idx)
        if to_remove:
            for idx in sorted(to_remove, reverse=True):
                st.session_state["constraints"].pop(idx)

    st.divider()
    st.subheader("Node Relation 그래프")
    st.caption("동일 담보순번 안에서 보기/납기를 비교해 방향성을 그립니다.")
    nodes = [row_to_node(r) for r in rows]
    edges = compute_edges(rows, nodes)
    if st.session_state["constraints"]:
        edges = apply_constraints(rows, nodes, edges, st.session_state["constraints"])
    # 종별 역전 비교는 제거됨

    updated = st.button("사업비 업데이트", help="방향에 맞게 a1을 조정합니다.")
    if updated:
        graph_before = build_graph(rows, edges)
        updated_rows, changes = apply_expense_updates(rows, edges)
        st.session_state["rows"] = updated_rows

        nodes_after = [row_to_node(r) for r in updated_rows]
        edges_after = compute_edges(updated_rows, nodes_after)
        if st.session_state["constraints"]:
            edges_after = apply_constraints(
                updated_rows, nodes_after, edges_after, st.session_state["constraints"]
            )
        # 종별 역전 비교는 제거됨
        graph_after = build_graph(updated_rows, edges_after)

        col_before, col_after = st.columns(2)
        with col_before:
            st.markdown("**업데이트 전**")
            st.graphviz_chart(graph_before, use_container_width=True)
        with col_after:
            st.markdown("**업데이트 후**")
            st.graphviz_chart(graph_after, use_container_width=True)

        if changes:
            st.success(f"사업비 {changes}건을 업데이트했습니다.")
        else:
            st.info("조정할 사업비가 없습니다.")
    else:
        graph = build_graph(rows, edges)
        st.graphviz_chart(graph, use_container_width=True)


if __name__ == "__main__":
    main()
