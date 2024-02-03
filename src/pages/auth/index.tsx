import Link from "next/link";

export default function AuthPage(){
    return <div>
        <h1>Auth Page</h1>
        <Link href={"/auth/sign-in"}>Login Page</Link>
        <Link href={"/auth/sign-up"}>Sign Up Page</Link>
    </div>
}