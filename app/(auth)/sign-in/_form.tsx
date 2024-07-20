"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import useForm from "@/lib/hooks/use-form";
import useAuth from "@/lib/provider/use-auth";
import { AuthError } from "@supabase/supabase-js";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";

interface InputProps {
  email: string;
  password: string;
}

export default function SignInForm() {
  const router = useRouter();
  const { signInWithEmailAndPassword } = useAuth();
  const { values, errors, isLoading, handleChange, handleSubmit } =
    useForm<InputProps>({
      initialValues: { email: "", password: "" },
      onSubmit: async (input) => {
        await signInWithEmailAndPassword(input.email, input.password)
          .then(() => {
            toast.success("Sign In Success", {
              position: "top-center",
            });
            router.replace("/");
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
        <div className="flex flex-col gap-y-1">
          <label>Email</label>
          <Input
            name="email"
            type="email"
            value={values.email}
            onChange={handleChange}
            placeholder="Email"
          />
        </div>
        <div className="flex flex-col gap-y-1">
          <label>Password</label>
          <Input
            name="password"
            type="password"
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
