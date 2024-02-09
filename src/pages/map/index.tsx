import { useState } from "react"
import Map from "@/components/map/Map"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faLocation, faMap, faSearch } from "@fortawesome/free-solid-svg-icons"
import Loc from "@/util/constant/location"

const DEFAULT_LAT = 37.497624203
const DEFAULT_LNG = 127.03088379

const MAX_LEVEL = 4;
const MIN_LEVEL = 1;


export default function MapPage() {


    const [map, setMap] = useState(null)
    const [level, setLevel] = useState<number>(2)
    const [currentLocation, setCurrentLocation] = useState<Loc>({
        lat: DEFAULT_LAT,
        lng: DEFAULT_LNG
    })

    const handleLevelUp = () => {
        if (level < MAX_LEVEL) {
            setLevel(level + 1)
        }
    }
    const handleLevelDown = () => {
        if (level > MIN_LEVEL) {
            setLevel(level - 1)
        }
    }

    return <div className="h-screen w-full">
        <div className="items-center flex justify-between mx-2">
            <div className="p-2 flex justify-start items-center text-3xl">
                <FontAwesomeIcon icon={faMap} />
                <h3 className="font-bold ml-3 mr-3 inline">지도</h3>
                <button className="round-md bg-sky-300 text-slate-600 hover:bg-sky-200 text-xl font-semibold ml-3 rounded-md px-2" onClick={handleLevelUp} disabled={level >= MAX_LEVEL}>+</button>
                <button className="round-md bg-sky-300 text-slate-600 hover:bg-sky-200 text-xl font-semibold ml-3 rounded-md px-2" onClick={handleLevelDown} disabled={level <= MIN_LEVEL}>-</button>
            </div>
            <ul className="justify-between flex">
                <li className="mr-5">

                    <button className="bg-slate-600 rounded-lg p-2 text-white hover:bg-slate-500 w-18 justify-around">
                        <FontAwesomeIcon icon={faLocation} />
                        <label className="ml-2 font-semibold">추가</label>
                    </button>
                </li>
                <li>
                    <button className="bg-slate-600 rounded-lg p-2 text-white hover:bg-slate-500 w-18 justify-around">
                        <FontAwesomeIcon icon={faSearch} />
                        <label className="ml-2 font-semibold">검색</label>
                    </button>
                </li>
            </ul>
        </div>

        <section>
            <Map setMap={setMap} level={level} loc={currentLocation} />
        </section>
    </div>

}