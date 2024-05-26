"use client";

import {
  Accordion,
  AccordionItem,
  Button,
  DateRangePicker,
  DateValue,
  RangeValue,
} from "@nextui-org/react";
import { parseDate, getLocalTimeZone } from "@internationalized/date";
import { useDateFormatter } from "@react-aria/i18n";
import { useEffect, useState } from "react";
import { formatDate } from "@/lib/util/date-format-util";
import { Address, Country } from "@/lib/contant/map";
import HashatagForm from "../post/item/hashtag-form";
import SelectCountryForm from "./select-country-form";
import SelectAddressForm from "./select-address-form";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCheck } from "@fortawesome/free-solid-svg-icons";
import CountryFlag from "react-country-flag";
import CustomTextarea from "../common/custom-textarea";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import axios from "axios";
import { NextEndPoint } from "@/lib/contant/end-point";
import { v4 } from "uuid";
import CustomInput from "../common/custom-input";

export default function AddPlanForm() {
  // 로딩여부
  const [isLoading, setIsLoading] = useState<boolean>(false);
  // 작성완료여부
  const [isFullfilled, setIsFullfilled] = useState<boolean>(false);
  // 여행 일정
  const [dateRange, setDateRange] = useState<RangeValue<DateValue>>({
    start: parseDate(formatDate({ dt: new Date() })),
    end: parseDate(formatDate({ dt: new Date() })),
  });
  let formatter = useDateFormatter({ dateStyle: "long" });
  // 여행국가
  const [country, setCountry] = useState<Country | null>(null);
  // 여행지
  const [place, setPlace] = useState<Address | null>(null);
  // 해시태그
  const [hashtags, setHashtags] = useState<string[]>([]);
  // 본문
  const [title, setTitle] = useState<string>("");
  // 본문
  const [content, setContent] = useState<string>("");
  // 라우터
  const router = useRouter();

  useEffect(() => {
    if (dateRange && country && place && title) {
      setIsFullfilled(true);
    } else {
      setIsFullfilled(false);
    }
  }, [dateRange, country, place, title]);

  const handleSubmit = async () => {
    try {
      setIsLoading(true);
      // validate
      if (!isFullfilled) {
        toast.warn("Plz complete the form");
        return;
      }

      await axios
        .post(NextEndPoint.createTravelPlan, {
          start_date: dateRange.start.toDate(getLocalTimeZone()),
          end_date: dateRange.start.toDate(getLocalTimeZone()),
          country_code: country?.countryCode,
          mapbox_id: place?.properties.mapbox_id,
          coordinate: [
            place?.properties?.coordinates.latitude,
            place?.properties?.coordinates.longitude,
          ],
          place_name: place?.properties.place_formatted,
          title,
          content,
          hashtags,
        })
        .then(() => {
          // on success
          toast.success("Success");
          router.replace("/map");
        })
        .catch((error) => {
          // on failure
          console.error(error);
          toast.error("Error Occurs...");
        });
    } catch (error) {
      console.error(error);
      toast.error("Error Occurs...");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="w-full rounded-lg px-5 py-2">
      <Accordion>
        {/* 날짜 */}
        <AccordionItem
          key="date"
          aria-label="date"
          title={
            <div className="flex gap-x-5 items-center">
              <h3 className="font-bold text-xl">Schedule</h3>
              <FontAwesomeIcon icon={faCheck} className="text-sm" />
            </div>
          }
          subtitle={
            <span className="text-lg font-semibold">
              {formatter.formatRange(
                dateRange.start.toDate(getLocalTimeZone()),
                dateRange.end.toDate(getLocalTimeZone())
              )}
            </span>
          }
        >
          <div className="p-2 bg-slate-100 rounded-lg">
            <DateRangePicker value={dateRange} onChange={setDateRange} />
          </div>
        </AccordionItem>

        {/* 나라 */}
        <AccordionItem
          key="country"
          aria-label="country"
          title={
            <div className="flex gap-x-5 items-center">
              <h3 className="font-bold text-xl">Country</h3>
              {country && (
                <FontAwesomeIcon icon={faCheck} className="text-sm" />
              )}
            </div>
          }
          subtitle={
            country && (
              <div className="gap-x-3 flex items-center text-slate-500">
                <CountryFlag countryCode={country.countryCode} svg />
                <span className="font-semibold text-lg">{country.label}</span>
                <span className="text-sm text-slate-500">({country.ko})</span>
              </div>
            )
          }
        >
          <div className="p-2 bg-slate-100 rounded-lg">
            <SelectCountryForm country={country} setCountry={setCountry} />
          </div>
        </AccordionItem>

        {/* 장소 검색 */}
        <AccordionItem
          key="place"
          aria-label="place"
          title={
            <div className="flex gap-x-3 items-center">
              <h3 className="font-bold text-xl">Place</h3>
              {place && <FontAwesomeIcon icon={faCheck} className="text-sm" />}
            </div>
          }
          subtitle={
            place && (
              <span className="font-semibold text-lg">
                {place.properties.place_formatted}
              </span>
            )
          }
        >
          <div className="p-2 bg-slate-100 rounded-lg">
            <SelectAddressForm
              country={country?.countryCode}
              placeholder="Search Place"
              selected={place}
              setSelected={setPlace}
            />
          </div>
        </AccordionItem>

        {/* 상세정보 */}
        <AccordionItem
          key="detail"
          aria-label="detail"
          title={
            <div className="flex gap-x-3 items-center">
              <h3 className="font-bold text-xl">Detail</h3>
              {title && <FontAwesomeIcon icon={faCheck} className="text-sm" />}
            </div>
          }
        >
          <div className="p-2 bg-slate-100 rounded-lg">
            {/* 제목 */}
            <div>
              <label>TITLE</label>
              <CustomInput
                value={title}
                setValue={setTitle}
                maxLength={30}
                placehoder="Let's Travel"
              />
            </div>
            {/* 본문 */}
            <div>
              <label>CONTENT</label>
              <CustomTextarea
                value={content}
                setValue={setContent}
                maxLength={1000}
                maxRows={20}
                placehoder="Introduce Your Itinerary"
              />
            </div>
            {/* 해시태그 */}
            <div>
              <label>HASHTAG</label>
              <HashatagForm
                hideLabel
                hideCounterText
                placeholder={"tags"}
                hashtags={hashtags}
                setHashtags={setHashtags}
                isEdit={true}
              />
            </div>
          </div>
        </AccordionItem>
      </Accordion>

      {/* 제출 버튼 */}
      <div className="w-full mt-5">
        <Button
          className={`w-full cursor-pointer ${isLoading && "cursor-wait"} ${
            isFullfilled ? "bg-green-600" : "bg-slate-100"
          }`}
          disabled={isLoading}
          variant="flat"
          onClick={handleSubmit}
        >
          <span className="text-xl font-bold">SUBMIT</span>
        </Button>
      </div>
    </div>
  );
}
