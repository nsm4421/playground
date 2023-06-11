import IconButtonAtom from "@/components/atom/icon-button-atom";
import PaginationAtom from "@/components/atom/pagination-atom";
import { PencilIcon } from "@heroicons/react/24/solid";
import Link from "next/link";
import { Dispatch, SetStateAction } from "react";

export default function PaginationComponent(props: {
  page: number;
  setPage: Dispatch<SetStateAction<number>>;
  limit: number;
  totalCount: number;
}) {
  return (
    <div className="flex justify-between py-5">
      <div className="px-2">
        <label>Pagination</label>
        <PaginationAtom {...props} />
      </div>
      <div>
        <Link href={"/post/write"}>
          <IconButtonAtom
            disabled={false}
            label="Write"
            icon={<PencilIcon className="w-5 h-5" />}
          />
        </Link>
      </div>
    </div>
  );
}
