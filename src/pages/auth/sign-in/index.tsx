import SignInForm from "@/components/auth/sign_in_form";
import { fireAuth } from "@/data/remote/firebase";
import { signInWithEmailAndPassword } from "firebase/auth";

export default function SignInPage() {

    const signIn = async (email: string, password: string) => await signInWithEmailAndPassword(fireAuth, email, password)

    return <div>
        <h1>로그인 페이지</h1>

        <SignInForm signIn={signIn} />
    </div>
}