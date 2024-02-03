"use client"

import Link from "next/link";
import { ChangeEvent, useState } from "react"
import axios from "axios";
import ApiRoute from "@/util/constant/api_route";

interface SignInFormState {
    email: string;
    emailErrorMessage: string;
    password: string;
    passwordErrorMessage: string;
    isVisible: boolean;
    errorMessage: string;
}

export default function SignInForm() {

    const MAX_LENGHTH = 20

    const [isLoading, setIsLoading] = useState<boolean>(false);

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
        setIsLoading(true)
        try {
            await axios.post(ApiRoute.signIn, {
                email: formState.email, password: formState.password
            }).then(console.log)
        } catch (err) {
            console.debug(err)
            setFormState({ ...formState, errorMessage: "Error occurs" })
        } finally {
            setIsLoading(false)
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
            <button onClick={onSubmit} disabled={isLoading}>LOGIN</button>
        </div>

        <div>
            <Link href={'/auth/sign-up'}>
                <p>Navigate To Sign Up Page</p>
            </Link>
        </div>
    </section>
}