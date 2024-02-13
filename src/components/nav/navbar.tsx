import { faRightFromBracket } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useSession } from "next-auth/react"
import Link from "next/link";
import { useRouter } from "next/router";
import { Tooltip } from 'react-tooltip'

interface NavItem {
    label: string;
    href: string;
    permit: "authenticatedOnly" | "unauthenticatedOnly" | "all";
}

const allNavItems: NavItem[] = [
    {
        label: "Home",
        href: "/",
        permit: "all"
    },
    {
        label: "Login",
        href: "/auth",
        permit: "unauthenticatedOnly"
    },
    {
        label: "Post",
        href: "/post",
        permit: "all"
    },
    {
        label: "Map",
        href: "/map",
        permit: "authenticatedOnly"
    },
]

// @TODO : 반응형으로 디자인하여 모바일 화면에서도 자연스럽게 만들기 
export default function Navbar() {
    const { data: session } = useSession()
    const router = useRouter()

    return <nav className="bg-gray-800 p-4 flex justify-between items-center text-white">
        <ul className="flex">
            {
                allNavItems.filter(item => {
                    switch (item.permit) {
                        case "all":
                            return true
                        case "authenticatedOnly":
                            return session
                        case "unauthenticatedOnly":
                            return !session
                    }
                }).map((navItem: NavItem, index: number) => (<li key={index} className={`${router.pathname === navItem.href ? "text-gray-100 font-bold" : "text-gray-500"} mr-4 text-2xl hover:text-rose-300 items-center`}>
                    <Link href={navItem.href}>
                        {navItem.label}
                    </Link>
                </li>))
            }
        </ul>
        <div className="flex">
            {
                session && <div>

                    {/* 이메일 */}
                    <span className="text-lg font-semibold mr-3">{session.user.email}</span>

                    {/* 로그아웃 버튼 */}
                    <button data-tooltip-id="logout-button"
                        data-tooltip-content="로그아웃"
                        data-tooltip-place="bottom-start"
                        className="text-lg p-2 rounded-md font-semibold hover:bg-sky-600">
                        <Tooltip id="logout-button" />
                        <FontAwesomeIcon icon={faRightFromBracket} />
                    </button>
                </div>
            }
        </div>
    </nav>
}