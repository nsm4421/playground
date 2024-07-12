import SignOutButton from "../auth/sign_out_button";

export default function HomeNavbar(){
    return <nav className="w-full justify-between flex">
        <div>
            <span>Hi</span>
            <span>Hi</span>
        </div>
        <div>
            <SignOutButton/>
        </div>
    </nav>
}