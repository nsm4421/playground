"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import signUpWithEmaiAndPasswordAction from "@/lib/actions/sign-up";
import useForm from "@/lib/hooks/use-form";
import { ChangeEvent } from "react";

interface InputProps {
  email: string;
  password: string;
  passwordConfirm: string;
}

export default function SignUpForm() {
  const { values, errors, isLoading, handleChange, handleSubmit } =
    useForm<InputProps>({
      initialValues: { email: "", password: "", passwordConfirm: "" },
      onSubmit: async (input) => {
        await signUpWithEmaiAndPasswordAction({
          ...input,
          // TODO : 회원가입 성공, 실패 시 이벤트
          onSuccess: console.log,
          onError: () => {},
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
        if (input.password === "" || input.password.length < 5) {
          return false;
        } else if (input.password !== input.passwordConfirm) {
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

        <div>
          <Input
            name="passwordConfirm"
            value={values.passwordConfirm}
            onChange={handleChange}
            placeholder="Password Confirm"
          />
        </div>

        <div>
          {values.email}
          {values.password}
          {values.passwordConfirm}
        </div>

        <div>
          <Button onClick={handleSubmit} disabled={isLoading}>
            Submit
          </Button>
        </div>
      </div>
    </>
  );
}
