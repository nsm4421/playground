import { Pagination } from "@mantine/core";
import { SetStateAction, Dispatch } from "react";
import {
  IconArrowBarToRight,
  IconArrowBarToLeft,
  IconArrowLeft,
  IconArrowRight,
  IconGripHorizontal,
} from "@tabler/icons-react";

export default function PagingBar({
  pageNumber,
  setPageNumber,
  totalPages,
}: {
  pageNumber: number;
  setPageNumber: Dispatch<SetStateAction<number>>;
  totalPages: number;
}) {
  return (
    <Pagination
      value={pageNumber}
      onChange={setPageNumber}
      total={totalPages}
      radius="md"
      withEdges
      siblings={2}
      boundaries={2}
      nextIcon={IconArrowRight}
      previousIcon={IconArrowLeft}
      firstIcon={IconArrowBarToLeft}
      lastIcon={IconArrowBarToRight}
      dotsIcon={IconGripHorizontal}
    />
  );
}
