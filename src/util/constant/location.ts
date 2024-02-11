export interface Loc {
    latitude: number;
    longitude: number;
}

export interface RoadAdress {
    address_name: string,
    region_1depth_name: string,
    region_2depth_name: string,
    region_3depth_name: string,
    road_name: string,
    underground_yn: 'Y' | 'N',
    main_building_no: string,
    sub_building_no: string,
    building_name: string,
    zone_no: string
}