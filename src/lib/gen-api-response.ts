import { NextResponse } from "next/server";

interface Props<T> {
  data?: T;
  message?: string;
  status: number;
}

export function genApiResponse<T>({ data, message, status }: Props<T>) {
  return NextResponse.json({ data, message }, { status });
}
