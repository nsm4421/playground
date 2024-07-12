import { supabase } from "@/data/supabase/supbase_client";
import { useState } from "react";
import { v4 as uuid } from "uuid";

interface UseImageProps {
    bucket: string;
    pathPrefix: string;
}

/** 파일을 선택하고, Storage에 저장하는 Hook
 * @state files
 * @state isLoading
 * @state urls : 파일 다운로드 링크
 */
export default function UseFile({ bucket, pathPrefix }: UseImageProps) {

    const [files, setFiles] = useState<File[]>([])
    const [isLoading, setIsLoading] = useState<boolean>(false)
    const [urls, setUrls] = useState<string[]>([])

    const upload = async () => {
        setUrls([])
        setIsLoading(true)
        try {
            for (let file in files) {
                const { data, error } = await supabase.storage.from(bucket).upload(`${pathPrefix}/${uuid()}`, file, {
                    cacheControl: '3600',
                    upsert: false,
                })
                if (error) {
                    throw Error('error occurs on uploading file')
                }
                const { data: { publicUrl } } = supabase.storage.from('images').getPublicUrl(data.path);
                setUrls([...urls, publicUrl])
                console.log(urls)
            }
        } catch (err) {
            console.error(err)
        } finally {
            setIsLoading(false)
        }
    }

    return { files, setFiles, upload, isLoading, urls }
}