import { Button } from "@/components/ui/button";
import { Routes } from "@/lib/constant/routes";
import Link from "next/link";

export default function ChatPage(){
    return <main className="container">
        
        <div className="flex justify-between">
            <h1>CHAT</h1>
            <Link href={Routes.createChat}>
            <Button>Create</Button>
            </Link>
        </div>

        {/* 채팅방 목록 */}
        <section>
            <ul>
                <li>1</li>
                <li>2</li>
                <li>3</li>
            </ul>
        </section>
    </main>
}