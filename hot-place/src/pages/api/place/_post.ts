import { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../../prisma/prisma_client";
import { getServerSession } from "next-auth";
import { authOptions } from "../auth/[...nextauth]";
import { RoadAdress } from "@/data/model/location_model";
import { v4 as uuid4 } from "uuid";

interface RequestProps {
    content: string;
    hashtags: string[];
    images: string[];
    name: string;
    address: RoadAdress;
}

interface ResponseProps {
    message : string;
}

export default async function POST(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {

    // 로그인 여부 검사
    const session = await getServerSession(req, res, authOptions)
    if (!session) {
        res.status(401).json({ message: '인증되지 않은 사용자입니다' });
        return
    }

    try {
        const { content, hashtags, images, name, address }: RequestProps = req.body
        // 데이터 저장
        await prisma.place.create({
            data: {
                content, hashtags, images, name,
                roadAdressId: uuid4(),

                address: {
                    create: {
                        latitude: address.latitude,
                        longitude: address.longitude,
                        addressName: address.address_name,
                        regionName: [
                            address.region_1depth_name,
                            address.region_2depth_name,
                            address.region_3depth_name
                        ],
                        roadName: address.road_name,
                        undergroundYn: address.underground_yn,
                        mainBuildingNo: address.main_building_no,
                        subBuildingNO: address.sub_building_no,
                        buildingName: address.building_name,
                        zoneNo: address.zone_no
                    }
                }
            }
        })

        res.status(200).json({ message: "success to save place" })
    } catch (err) {
        console.error(err)
        res.status(500).json({ message: 'internal server error' })
    } finally {
        await prisma.$disconnect()
    }
}