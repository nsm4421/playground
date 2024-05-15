"use client";

import { useEffect, useRef } from "react";
import useMapState from "./map_state";

interface Props {}

export default function InitLocation(props: Props) {
  const initState = useRef(false);
  const { setLocation } = useMapState();

  useEffect(() => {
    if (!initState.current) {
      navigator.geolocation.getCurrentPosition(
        (pos) => {
          setLocation(pos);
          console.debug("현재 유저 위치 가져오기 성공");
        },
        (error) => {
          alert("위치권한이 허용되지 않아, 위치기능이 차단되었습니다");
          console.error(error);
        }
      );
    }
    initState.current = true;
  }, [props]);
  return <></>;
}
