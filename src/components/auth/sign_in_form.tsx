"use client"

import Link from "next/link";
import { ChangeEvent, useState } from "react"
import { UserCredential } from "firebase/auth";

interface SignInFormState {
    email: string;
    emailErrorMessage: string;
    password: string;
    passwordErrorMessage: string;
    isVisible: boolean;
    errorMessage: string;
}

interface SignInProps {
    signIn: (email: string, password: string) => Promise<UserCredential>
}

export default function SignInForm(props: SignInProps) {

    const MAX_LENGHTH = 20

    const [formState, setFormState] = useState<SignInFormState>({
        email: "",
        emailErrorMessage: "",
        password: "",
        passwordErrorMessage: "",
        isVisible: false,
        errorMessage: ""
    })

    const onChangeEmail = (e: ChangeEvent<HTMLInputElement>) => {
        const email = e.target.value
        if (email.length > MAX_LENGHTH) {
            setFormState({ ...formState, emailErrorMessage: `최대 ${MAX_LENGHTH}자 내외로 입력해주세요` })
            return
        }
        setFormState({ ...formState, email, emailErrorMessage: "" })
    }

    const onChangePassword = (e: ChangeEvent<HTMLInputElement>) => {
        const password = e.target.value
        if (password.length > MAX_LENGHTH) {
            setFormState({ ...formState, passwordErrorMessage: `최대 ${MAX_LENGHTH}자 내외로 입력해주세요` })
            return
        }
        setFormState({ ...formState, password, passwordErrorMessage: "" })
    }

    const onClickVisible = () => {
        setFormState({ ...formState, isVisible: !formState.isVisible })
    }

    const onSubmit = async () => {
        try {
            const credential = await props.signIn(formState.email, formState.password)
            console.log(credential)
        } catch (err) {
            console.debug(err)
            setFormState({ ...formState, errorMessage: "Error occurs" })
        }
    }

    return <section className="text-black" >
        <div>
            <label>EMAIL</label>
            <input name="email" type="email" value={formState.email} onChange={onChangeEmail} />
            {formState.emailErrorMessage && <p>{formState.emailErrorMessage}</p>}
        </div>

        <div>
            <label>PASSWORD</label>
            <input name="password" type={formState.isVisible ? "text" : "password"} value={formState.password} onChange={onChangePassword} />
            <button onClick={onClickVisible}>{formState.isVisible ? "HIDE" : "VISIBLE"}</button>
        </div>

        <div>
            <button onClick={onSubmit}>LOGIN</button>
        </div>

        <div>
            <Link href={'/auth/sign-up'}>
                <p>Navigate To Sign Up Page</p>
            </Link>
        </div>
    </section>
}