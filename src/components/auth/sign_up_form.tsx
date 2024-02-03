"use client"

import Link from "next/link";
import { ChangeEvent, useState } from "react"
import { useRouter } from "next/router";
import axios from "axios";
import ApiRoute from "@/constant/api_route";


interface SignUpFormState {
    email: string;
    emailErrorMessage: string;
    password: string;
    passwordErrorMessage: string;
    passwordConfirm: string;
    passwordConfirmErrorMessage: string;
    isPasswordVisible: boolean;
    isPasswordConfirmVisible: boolean;
    errorMessage: string;
}

export default function SignUpForm() {

    const MAX_LENGHTH = 20

    const router = useRouter()

    const [isLoading, setIsLoading] = useState<boolean>(false)

    const [formState, setFormState] = useState<SignUpFormState>({
        email: "",
        emailErrorMessage: "",
        password: "",
        passwordErrorMessage: "",
        passwordConfirm: "",
        passwordConfirmErrorMessage: "",
        isPasswordVisible: false,
        isPasswordConfirmVisible: false,
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

    const onChangePasswordConfirm = (e: ChangeEvent<HTMLInputElement>) => {
        const passwordConfirm = e.target.value
        if (passwordConfirm.length > MAX_LENGHTH) {
            setFormState({ ...formState, passwordConfirmErrorMessage: `최대 ${MAX_LENGHTH}자 내외로 입력해주세요` })
            return
        }
        setFormState({ ...formState, passwordConfirm, passwordConfirmErrorMessage: "" })
    }

    const handleIsPasswordVisible = () => {
        setFormState({ ...formState, isPasswordVisible: !formState.isPasswordVisible })
    }

    const handleIsPasswordConfirmVisible = () => {
        setFormState({ ...formState, isPasswordConfirmVisible: !formState.isPasswordConfirmVisible })
    }

    const onSubmit = async () => {
        setIsLoading(true)
        try {
            // TODO : validate email and password

            await axios.post(ApiRoute.signUp, {
                email: formState.email,
                password: formState.password
            }).then(console.log)


            // TODO : save user info in firestore
            router.push("/auth/sign-in")


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
            <input name="password" type={formState.isPasswordVisible ? "text" : "password"} value={formState.password} onChange={onChangePassword} />
            <button onClick={handleIsPasswordVisible}>{formState.isPasswordVisible ? "HIDE" : "VISIBLE"}</button>
        </div>

        <div>
            <label>PASSWORD CONFIRM</label>
            <input name="password_confirm" type={formState.isPasswordConfirmVisible ? "text" : "password"} value={formState.passwordConfirm} onChange={onChangePasswordConfirm} />
            <button onClick={handleIsPasswordConfirmVisible}>{formState.isPasswordConfirmVisible ? "HIDE" : "VISIBLE"}</button>
        </div>

        <div>
            <button onClick={onSubmit} disabled={isLoading}>Sign UP</button>
        </div>

        <div>
            <Link href={'/auth/sign-in'}>
                <p>Navigate To Login Page</p>
            </Link>
        </div>

        <div>
            {formState.errorMessage && <p>{formState.errorMessage}</p>}
        </div>
    </section>
}