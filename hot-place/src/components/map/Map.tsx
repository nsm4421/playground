import { Loc } from "@/data/model/location_model";
import Script from "next/script"
import { Dispatch, SetStateAction, useCallback, useEffect } from "react"

declare global {
    interface Window {
        kakao: any
    }
}

interface MapProps {
    level: number;
    setMap: Dispatch<SetStateAction<any>>;
    loc: Loc;
}

export default function Map({ level, setMap, loc }: MapProps) {

    const loadMap = () => window.kakao.maps.load(() => {
        const container = document.getElementById("map")
        const option = {
            center: new window.kakao.maps.LatLng(loc.latitude, loc.longitude),
            level
        }
        const map = new window.kakao.maps.Map(container, option)
        setMap(map)
    })

    useEffect(() => {
        return () => {
            if (window.kakao) {
                loadMap()
            }
        }
    }, [level])



    return <div className="w-full h-full">
        <Script
            strategy="afterInteractive"
            type="text/javascript"
            onReady={loadMap}
            src={`//dapi.kakao.com/v2/maps/sdk.js?appkey=${process.env.NEXT_PUBLIC_KAKAO_API_SECRET}&autoload=false`} />
        <div id="map" style={{ height: '90vh' }}></div>
    </div>
}