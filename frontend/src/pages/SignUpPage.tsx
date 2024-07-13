import { ChangeEvent, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import useAuth from "../hook/use-auth";

export default function SignUpPage() {
  const router = useNavigate();
  const { signUp } = useAuth();
  const [isValid, setIsValid] = useState<boolean>(false);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [passwordConfirm, setPasswordConfirm] = useState<string>("");

  const handleChangeEmail = (e: ChangeEvent<HTMLInputElement>) =>
    setEmail(e.target.value);

  const handleChangePassword = (e: ChangeEvent<HTMLInputElement>) =>
    setPassword(e.target.value);

  const handleChangePasswordConfirm = (e: ChangeEvent<HTMLInputElement>) =>
    setPasswordConfirm(e.target.value);

  const handleSubmit = async () => {
    try {
      setIsLoading(true);
      await signUp({
        email,
        password,
        onSuccess: () => router("/auth/sign-in"),
        onError: () => alert("Sign Up Fails..."),
      });
    } catch (error) {
      alert("Sign Up Fails...!");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    setIsValid(
      email !== "" &&
        password !== "" &&
        passwordConfirm !== "" &&
        password === passwordConfirm
    );
  }, [email, password, passwordConfirm]);

  return (
    <main className="mt-5 flex flex-col gap-y-5">
      {isLoading && (
        <div className="absolute inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
          <div className="text-center text-white">
            <div className="loader mx-auto mb-4"></div>
            <p className="text-xl font-bold">Loadings...</p>
          </div>
        </div>
      )}

      <div className="flex flex-col gap-y-2">
        <h1 className="text-xl font-semibold">Sign Up Page</h1>
        <p className="text-sm text-slate-500">
          Easily register account with email and password
        </p>
      </div>

      <section className="px-3 mt-10 flex flex-col gap-y-5">
        {/* Email */}
        <div className="gap-y-2 flex flex-col">
          <p className="block text-sm font-medium text-gray-900 dark:text-white">
            Email
          </p>
          <input
            value={email}
            onChange={handleChangeEmail}
            type="email"
            className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            placeholder="karma@naver.com"
            required
          />
        </div>

        {/* Password */}
        <div className="gap-y-2 flex flex-col">
          <p className="block text-sm font-medium text-gray-900 dark:text-white">
            Password
          </p>
          <input
            value={password}
            onChange={handleChangePassword}
            type="password"
            className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            placeholder="qwer1234!"
            required
          />
        </div>

        {/* Confirm Password */}
        <div className="gap-y-2 flex flex-col">
          <p className="flex text-sm font-medium text-gray-900 dark:text-white">
            Confirm Password
          </p>
          <input
            value={passwordConfirm}
            onChange={handleChangePasswordConfirm}
            type="password"
            className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            placeholder="press password again"
            required
          />
        </div>

        {/* Button */}
        <div>
          <button
            onClick={handleSubmit}
            disabled={isLoading || !isValid}
            className={`bg-lime-500 hover:bg-lime-700 text-white font-bold py-2 px-4 rounded
            ${isValid ? "cursor-pointer" : " cursor-not-allowed"}`}
          >
            Submit
          </button>
        </div>
      </section>
    </main>
  );
}
