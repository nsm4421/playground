"use client";

import { useRouter } from "next/navigation";
import { ChangeEvent, useState } from "react";

interface InputProps {
  email: string;
  password: string;
}

export default function RegisterForm() {
  const router = useRouter();

  const [inputs, setInputs] = useState<InputProps>({
    password: "",
    email: "",
  });

  const [isLoading, setIsLoading] = useState(false);

  const handleInput = (name: string) => (e: ChangeEvent<HTMLInputElement>) => {
    setInputs({ ...inputs, [name]: e.target.value });
  };

  const handleSubmit = async () => {
    setIsLoading(true);
    try {
      const res = await fetch("/api/auth/register", {
        method: "POST",
        body: JSON.stringify({ ...inputs }),
      }).then((res) => res.json());

      // register success
      if (res.data) {
        router.push("/auth/login");
        return;
      }

      // register fail
      alert(res.message);
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
          placeholder="Email Address"
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
        {isLoading ? "Loadings..." : "Sign In"}
      </button>
    </div>
  );
}
