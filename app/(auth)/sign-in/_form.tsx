"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import signInWithEmaiAndPasswordAction from "@/lib/actions/sign-in";
import useForm from "@/lib/hooks/use-form";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";

interface InputProps {
  email: string;
  password: string;
}

export default function SignInForm() {
  const router = useRouter();
  const { values, errors, isLoading, handleChange, handleSubmit } =
    useForm<InputProps>({
      initialValues: { email: "", password: "" },
      onSubmit: async (input) => {
        await signInWithEmaiAndPasswordAction({
          ...input,
          onSuccess: (user) => {
            // TODO : 전역변수에 user 저장
            toast.success("Sign In Success", {
              position: "top-center",
            });
            router.replace("/");
          },
          onError: (error) => {
            toast.error(`${error?.code ?? "error..."}`, {
              position: "top-center",
            });
          },
        });
      },
      // TODO : 오류메세지 띄우기
      validate: (input) => {
        // 이메일 필드 검사
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(input.email)) {
          return false;
        }
        // 비밀번호 검사
        else if (input.password === "" || input.password.length < 5) {
          return false;
        }
        // 통과
        return true;
      },
    });

  return (
    <>
      <div className="flex flex-col gap-y-5">
        <div>
          <Input
            name="email"
            value={values.email}
            onChange={handleChange}
            placeholder="Email"
          />
        </div>
        <div>
          <Input
            name="password"
            value={values.password}
            onChange={handleChange}
            placeholder="Password"
          />
        </div>

        <div className="flex flex-row-reverse">
          <Button onClick={handleSubmit} disabled={isLoading}>
            Submit
          </Button>
        </div>
      </div>
    </>
  );
}
