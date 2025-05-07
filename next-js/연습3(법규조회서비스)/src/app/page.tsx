"use client";

import { useLawState } from "@/store/law";
import SelectLaw from "./select-law";
import LawContent from "./law-content";

export default function EntryPage() {
  const { laws, history } = useLawState();

  return <div>{laws && history ? <LawContent /> : <SelectLaw />}</div>;
}
