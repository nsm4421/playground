import SignUpForm from "@/components/auth/sign_up_form";
import { fireAuth } from "@/data/remote/firebase";
import { createUserWithEmailAndPassword, getAuth } from "firebase/auth";


export default function SignUpPage() {

    const signUp = async (email: string, password: string) => await createUserWithEmailAndPassword(fireAuth, email, password)

    return <div>
        <div>Sign UP</div>

        <h1>Sign UP Page</h1>

        <SignUpForm signUp={signUp} />

    </div>
}