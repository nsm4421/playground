import ApiRoute from "@/util/constant/api_route";
import { faHashtag, faImage, faXmark } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import axios from "axios";
import { useRouter } from "next/router";
import { ChangeEvent, useEffect, useState } from "react"
import Image from 'next/image';
import { supabase } from "@/data/supabase/supbase_client";
import { v4 as uuidv4 } from 'uuid';

interface PostState {
    content: string;
    contentErrorMessage: string;
    hashtags: string[];
    images: File[];
    imagesErrorMessage: string;
    currentHashtag: string;
    currentHashtagErrorMessage: string;
    isLoading: boolean;
}

export default function CreatePostPage() {

    const MAX_CONTENT_LENGTH = 1000         // 본문 글자수 제한
    const MAX_HASHTAG_LENGTH = 15           // 해시태그 글자수 제한
    const MAX_HASHTAG_COUNT = 5             // 해시태그 개수 제한
    const MAX_IMAGE_COUNT = 3               // 이미지 개수 제한
    const INPUT_FILE_ID = 'image'             // input id prefix

    const [postState, setPostState] = useState<PostState>({
        content: "",
        contentErrorMessage: "",
        hashtags: [],
        images: [],
        imagesErrorMessage: "",
        currentHashtag: "",
        currentHashtagErrorMessage: "",
        isLoading: false
    })

    const router = useRouter()

    /// 본문
    const handleContent = (e: ChangeEvent<HTMLTextAreaElement>) => {
        const text = e.target.value
        text.length <= MAX_CONTENT_LENGTH
            ? setPostState({ ...postState, content: text, contentErrorMessage: "" })
            : setPostState({ ...postState, contentErrorMessage: `최대 ${MAX_CONTENT_LENGTH}까지 입력 가능합니다` })
    }

    useEffect(() => {
        setPostState({ ...postState, contentErrorMessage: postState.content.length === 0 ? '본문을  입력해주세요' : '' })
    }, [postState.content])

    /// 해시태그
    const handleCurrentHashtag = (e: ChangeEvent<HTMLInputElement>) => {
        const text = e.target.value
        if (text.includes("#")) {
            setPostState({ ...postState, currentHashtagErrorMessage: "#를 사용할 수 없습니다" })
        } else if (text.length > MAX_HASHTAG_LENGTH) {
            setPostState({ ...postState, currentHashtagErrorMessage: `최대 ${MAX_HASHTAG_LENGTH}자 내외로 입력해주세요` })
        } else {
            setPostState({ ...postState, currentHashtag: text, currentHashtagErrorMessage: "" })
        }
    }

    const handleKeyUp = (e: any) => {
        if (e.key !== "Enter") return
        const newHashtag = e.target.value.trim()

        if (postState.hashtags.length >= MAX_HASHTAG_COUNT) {
            setPostState({ ...postState, currentHashtagErrorMessage: `최대 ${MAX_HASHTAG_COUNT}개까지 입력가능합니다` })
        } else if (postState.hashtags.includes(newHashtag)) {
            setPostState({ ...postState, currentHashtagErrorMessage: `${newHashtag}는 중복된 해시태그입니다` })
        } else if (e.keyCode === 32) {
            setPostState({ ...postState, currentHashtagErrorMessage: "해시태그에 띄어쓰기를 사용할 수 없습니다" })
        } else if (newHashtag !== "") {
            setPostState({ ...postState, hashtags: [...postState.hashtags, newHashtag], currentHashtag: "", currentHashtagErrorMessage: "" })
        }
    }

    const handleDeleteHashtag = (index: number) => () => {
        const newHashtags = [...postState.hashtags]
        if (index < 0 || index >= newHashtags.length) {
            console.error("해시태그 삭제 기능 시 부적절한 index가 들어옴")
            return
        }
        newHashtags.splice(index, 1)
        setPostState({ ...postState, hashtags: newHashtags })
    }

    /// 이미지
    const handleClickImageButton = () => {
        document.getElementById(INPUT_FILE_ID)?.click()
    }

    const handleOnSelect = async (event: React.ChangeEvent<HTMLInputElement>): Promise<void> => {
        const selected = event.target.files;
        if (!selected || selected.length === 0) return
        setPostState({ ...postState, images: Array.from(selected) })

    }

    /// 포스트 업로드
    const handleUpload = async () => {
        setPostState({ ...postState, isLoading: true })
        try {
            // 필드 검사
            if (postState.content.trim() === "") {
                alert('본문을 입력해주세요')
                return
            }

            // 이미지 업로드
            let downloadLinks: string[] = []
            for (let image in postState.images) {
                const { data, error } = await supabase.storage.from('images').upload(`post/${uuidv4()}`, image, {
                    cacheControl: '3600',
                    upsert: false,
                })
                if (error) {
                    console.error('이미지 업로드 중 에러 발생')
                    window.alert('이미지 업로드 중 에러가 발생했습니다')
                    return
                }
                const { data: { publicUrl } } = supabase.storage.from('images').getPublicUrl(data.path);
                downloadLinks.push(publicUrl)
            }

            // DB에 데이터 업로드
            await axios({
                ...ApiRoute.createPost,
                data: {
                    content: postState.content,
                    hashtags: postState.hashtags,
                    images: downloadLinks
                }
            })

            // 성공 시 포스팅 페이지로
            router.push("/post")
            window.alert("포스팅 업로드에 성공하였습니다")
        } catch {
            window.alert('포스트 업로드 중 에러가 발생했습니다')
        } finally {
            setPostState({ ...postState, isLoading: false })
        }
    }

    return <div className="h-full w-full">
        <div className="p-3 mt-3 flex justify-between px-3">
            <h1 className="text-3xl font-extrabold inline">포스팅 업로드</h1>
            <button className={postState.isLoading ? "bg-slate-400 text-slate-200 text-xl rounded-md p-2" : "bg-green-700 text-white text-xl rounded-md p-2"}
                onClick={handleUpload} disabled={postState.isLoading}>
                {postState.isLoading ? "로딩중..." : "업로드"}</button>
        </div>

        <section className="px-3">

            {/* 본문 */}
            <div className="mt-3">

                <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">Content</h3>

                <textarea className="mt-3 tracking-wider text-lg w-full max-h-10em resize-none border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
                    rows={5}
                    onChange={handleContent}
                    value={postState.content}
                    placeholder="본문을 입력해주세요" />
                <div className="flex justify-between">
                    <span className="text-rose-700">{postState.contentErrorMessage}</span>
                    <span className="text-slate-700">{postState.content.length}/{MAX_CONTENT_LENGTH}</span>
                </div>
            </div>


            {/* 해시태그 */}
            <div className="mt-5">
                <div className="grid grid-cols-[auto,1fr] gap-4 items-start">
                    <h3 className="text-xl h-fit font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">Hashtag</h3>
                    <div>
                        <input className="w-full tracking-wider text-lg border rounded-md focus:outline-none focus:ring focus:border-blue-100 p-2"
                            placeholder={`해시태그를 입력하고 엔터를 눌러주세요(최대 ${MAX_HASHTAG_COUNT}개)`}
                            value={postState.currentHashtag} onChange={handleCurrentHashtag}
                            onKeyUp={handleKeyUp} />
                        <div className="flex justify-between">
                            <span className="text-rose-700">{postState.currentHashtagErrorMessage}</span>
                            <span className="text-slate-700">{postState.currentHashtag.length}/{MAX_HASHTAG_LENGTH}</span>
                        </div>
                    </div>

                </div>
                <ul className="mt-2 flex-wrap flex">
                    {
                        postState.hashtags.map((hashtag, index) => <li className="text-xl font-bold inline mt-2 mr-3 p-1 rounded-md text-sky-600 border-sky-300 border-2" key={index}>
                            <FontAwesomeIcon icon={faHashtag} className="text-sm mr-2" />
                            <label className="mr-2">{hashtag}</label>
                            <FontAwesomeIcon icon={faXmark} className="text-sm cursor-pointer" onClick={handleDeleteHashtag(index)} />
                        </li>)
                    }
                </ul>
            </div>

            {/* 이미지 */}
            <div className="mt-5">

                <div className="flex justify-between">
                    <div>
                        <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline">Images</h3>
                        <span className="ml-5 text-gray-500">{`최대 ${MAX_IMAGE_COUNT}개의 이미지를 업로드할 수 있습니다`}</span>
                    </div>
                    <button className="hover:bg-orange-300 p-1 rounded-md cursor"
                        onClick={handleClickImageButton}>
                        <FontAwesomeIcon icon={faImage} />
                        <label className="ml-3">이미지 선택하기</label>
                        <input id={INPUT_FILE_ID} className="hidden" accept="image/*" type="file" multiple={true} onChange={handleOnSelect} />
                    </button>
                </div>

                <ul className="flex justify-start mt-3 mx-3">
                    {
                        (postState.images && !postState.isLoading) && postState.images.map((image, index) => <li key={index}
                            className="mr-4 h-auto">
                            <Image src={URL.createObjectURL(image)} alt={`${index}th-image`} width={100} height={100} />
                        </li>)
                    }
                </ul>
            </div>
        </section>
    </div>
}