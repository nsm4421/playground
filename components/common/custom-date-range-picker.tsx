"use client";

import { DateRangePicker, DateValue, RangeValue } from "@nextui-org/react";
import { getLocalTimeZone } from "@internationalized/date";
import { useDateFormatter } from "@react-aria/i18n";
import { Dispatch, SetStateAction, useState } from "react";

interface Props {
  label?: string;
  range: RangeValue<DateValue>;
  setRange: Dispatch<SetStateAction<RangeValue<DateValue>>>;
  hideFormat?: boolean;
}

export default function CustomDateRangePicker(props: Props) {
  const handleChange = (v: RangeValue<DateValue>) => {
    props.setRange(v);
  };

  let formatter = useDateFormatter({ dateStyle: "long" });

  return (
    <div>
      <div className="w-full">
        <DateRangePicker
          label={props.label ?? "Date Range"}
          value={props.range}
          onChange={handleChange}
        />
      </div>
      {!props.hideFormat && props.range && (
        <div className="font-bold mx-2">
          {formatter.formatRange(
            props.range.start.toDate(getLocalTimeZone()),
            props.range.end.toDate(getLocalTimeZone())
          )}
        </div>
      )}
    </div>
  );
}
