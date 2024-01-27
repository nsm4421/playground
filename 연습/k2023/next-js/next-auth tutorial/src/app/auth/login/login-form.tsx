"use client";

import { signIn } from "next-auth/react";
import { useRouter } from "next/navigation";
import { ChangeEvent, useState } from "react";

interface InputProps {
  email: string;
  password: string;
}

export default function LoginForm() {
  const router = useRouter();

  const [inputs, setInputs] = useState<InputProps>({
    email: "",
    password: "",
  });

  const [isLoading, setIsLoading] = useState(false);

  const handleInput = (name: string) => (e: ChangeEvent<HTMLInputElement>) => {
    setInputs({ ...inputs, [name]: e.target.value });
  };

  const handleSubmit = async (e:any) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      const res = await signIn("email-password-credentials", {
        ...inputs, redirect:false
      });
      if (res && res.error){
        alert(res.error);
        return;
      }
      router.push("/")
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };
  return (
    <div>
      <div>
        <label>Email</label>
        <input
          value={inputs.email}
          onChange={handleInput("email")}
          type="text"
          placeholder="email for login"
        />
      </div>
      <div>
        <label>Password</label>
        <input
          value={inputs.password}
          onChange={handleInput("password")}
          type="password"
          placeholder="Password for login"
        />
      </div>

      <button onClick={handleSubmit} disabled={isLoading}>
        {isLoading ? "Loadings..." : "Login"}
      </button>
    </div>
  );
}
