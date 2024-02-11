import { useCallback, useEffect, useState } from "react";
import Loc from "../../data/model/location_model";
import { DateTime } from "next-auth/providers/kakao";

// 강남역 위치
const DEFAULT_LAT = 37.497624203
const DEFAULT_LNG = 127.03088379

export default function useGeoLocation() {

    const [isLoading, setIsLoding] = useState<boolean>(false)
    const [currentLocation, setCurrentLocation] = useState<Loc>({
        latitude: DEFAULT_LAT, longitude: DEFAULT_LNG
    })
    const [errorMessage, setErrorMessage] = useState<string>('')
    const [lastFetchedAt, setLastFetchedAt] = useState<number | null>(null)


    const reFetch = () => setLastFetchedAt(Date.now())

    // lastFetchedAt 필드 변경 시, 다시 위치정보 가져오기
    useEffect(() => {
        setIsLoding(true)
        // 위치정보가 제공되지 않는 브라우져인 경우
        if (!("geolocation" in navigator)) {
            setErrorMessage('위치정보가 제공되지 않는 브라우져입니다')
            console.error("Geolocation is not supported on browser");
            return
        }

        // 위치 정보 가져오기
        navigator.geolocation.getCurrentPosition(
            (position) => {
                const latitude = position.coords.latitude;
                const longitude = position.coords.longitude;
                setCurrentLocation({
                    latitude, longitude
                })
                setErrorMessage('')
            },
            (error) => {
                // 위치 권한이 거부된 경우
                if (error.code === error.PERMISSION_DENIED) {
                    setErrorMessage("위치 권한이 거부되었습니다")
                    console.error("user denied permission for location");
                }
                // 에러
                else {
                    setErrorMessage("위치 정보를 가져오는데 실패하였습니다")
                    console.error("Error getting location:", error.message);
                }
            }
        );
        setIsLoding(false)
        setLastFetchedAt(Date.now())

    }, [lastFetchedAt])

    return { isLoading, currentLocation, errorMessage, lastFetchedAt, reFetch }

}