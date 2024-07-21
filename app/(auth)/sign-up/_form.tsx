"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Routes } from "@/lib/constant/routes";

import useForm from "@/lib/hooks/use-form";
import useAuth from "@/lib/provider/use-auth";
import { AuthError } from "@supabase/supabase-js";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";

interface InputProps {
  email: string;
  password: string;
  passwordConfirm: string;
}

export default function SignUpForm() {
  const router = useRouter();
  const { signUpWithEmailAndPassword } = useAuth();
  const { values, errors, isLoading, handleChange, handleSubmit } =
    useForm<InputProps>({
      initialValues: { email: "", password: "", passwordConfirm: "" },
      onSubmit: async (input) => {
        await signUpWithEmailAndPassword(input.email, input.password)
          .then(() => {
            toast.success("Sign Up Success", {
              position: "top-center",
            });
            router.replace(Routes.signIn);
          })
          .catch((error: AuthError) => {
            toast.error(`${error?.code ?? "error..."}`, {
              position: "top-center",
            });
          });
      },
      validate: (input) => {
        // 이메일 필드 검사
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(input.email)) {
          toast.error("Email field is not valid", {
            position: "top-center",
          });
          return false;
        }
        // 비밀번호 검사
        if (input.password === "" || input.password.length < 5) {
          toast.error("Check password again", {
            position: "top-center",
          });
          return false;
        } else if (input.password !== input.passwordConfirm) {
          toast.error("Password is not matched", {
            position: "top-center",
          });
          return false;
        }
        // 통과
        return true;
      },
    });

  return (
    <div className="flex flex-col gap-y-5">
      <div className="flex flex-col gap-y-1">
        <label>Email</label>
        <Input
          name="email"
          type="email"
          value={values.email}
          onChange={handleChange}
          placeholder="karma@naver.com"
        />
      </div>
      <div className="flex flex-col gap-y-1">
        <label>Password</label>
        <Input
          name="password"
          type="password"
          value={values.password}
          onChange={handleChange}
          placeholder="1q2w3e4r!"
        />
      </div>

      <div className="flex flex-col gap-y-1">
        <label>Password Confirm</label>
        <Input
          name="passwordConfirm"
          type="password"
          value={values.passwordConfirm}
          onChange={handleChange}
          placeholder="1q2w3e4r!"
        />
      </div>

      <div className="flex flex-row-reverse">
        <Button onClick={handleSubmit} disabled={isLoading}>
          Submit
        </Button>
      </div>
    </div>
  );
}
