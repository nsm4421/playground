"use client";

import ButtonAtom from "@/components/atom/button-atom";
import InputAtom from "@/components/atom/input-atom";
import useInput from "@/util/hook/use-input";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { TrashIcon } from '@heroicons/react/24/solid';
import { XMarkIcon  } from '@heroicons/react/24/solid';


const MAX_LENGTH = 30;

export default function RegisterForm() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState(false);
  const { value: email, onChange: onEmailChange } = useInput(
    "",
    (v: string) => v.length < MAX_LENGTH
  );
  const { value: password, onChange: onPasswordChange } = useInput(
    "",
    (v: string) => v.length < MAX_LENGTH
  );
  const { value: passwordConfirm, onChange: onPasswordConfirm } = useInput(
    "",
    (v: string) => v.length < MAX_LENGTH
  );
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const validateInputs = () => {
    if (!/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/.test(email)) {
      setErrorMessage("Email is not valid");
      return false;
    }
    if (
      !/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{10,}$/.test(
        password
      )
    ) {
      setErrorMessage(
        "Password must contain at least one letter, digit, special character and its length must be larger than or equal to 10"
      );
      return false;
    }
    if (password !== passwordConfirm) {
      setErrorMessage("Password and its confirm are not match");
      return false;
    }
    setErrorMessage(null);
    return true;
  };

  const clearErrorMessage = () => setErrorMessage(null);

  const handleSubmit = async () => {
    try {
      setIsLoading(true);
      if (!(await validateInputs())) return;
      await fetch("/api/auth/register", {
        method: "POST",
        body: JSON.stringify({ email, password }),
      }).then((res) => {
        // on success → go to home
        if (res.ok) {
          alert("Sign Up Success");
          router.push("/");
          return;
        }
        setErrorMessage(res.statusText);
      });
    } catch (err) {
      alert(err ?? "Error");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      {/* Form */}
      <div className="px-4 py-4">
        <InputAtom
          label="Email"
          onChange={onEmailChange}
          placeholder="example@naver.com"
        />
      </div>
      <div className="px-4 py-4">
        <InputAtom
          label="Password"
          type="password"
          onChange={onPasswordChange}
          placeholder="1q2w3e4r!"
        />
      </div>
      <div className="px-4 py-4">
        <InputAtom
          label="Password Confirm"
          type="password"
          onChange={onPasswordConfirm}
          placeholder="1q2w3e4r!"
        />
        {passwordConfirm === "" ? (
          <span className="text-gray-400 text-sm">Type password again</span>
        ) : (
          password !== passwordConfirm && (
            <span className="text-gray-400 text-sm">
              Password is not matched
            </span>
          )
        )}
      </div>

      {/* Error Message */}
      {errorMessage && (
        <div className="px-4 py-2 justify-between">          
          <span className="text-red-400 text-sm">{errorMessage}</span>
          <XMarkIcon onClick={clearErrorMessage} className="w-6 h-6 float-right hover:text-red-400"/>
        </div>
      )}

      {/* Submit Button */}
      <div className="px-4 py-4 flex justify-end">
        <ButtonAtom
          color={"green"}
          label={"Register"}
          onClick={handleSubmit}
          disabled={isLoading}
        />
      </div>
    </>
  );
}
