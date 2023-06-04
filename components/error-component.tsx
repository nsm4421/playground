"use client"

import { useRouter } from "next/navigation"

export default function ErrorComponent(){
    const router = useRouter();
    const handleGoBack = () => router.back();
    return <>
        <h1>Error</h1>
        <button onClick={handleGoBack}>Go Back</button>
    </>
}