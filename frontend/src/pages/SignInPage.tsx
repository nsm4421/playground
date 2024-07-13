import { ChangeEvent, useState } from "react";
import { useNavigate } from "react-router-dom";
import SignInAction from "../action/sign-in";

export default function SignInPage() {
  const router = useNavigate();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const handleChangeEmail = (e: ChangeEvent<HTMLInputElement>) =>
    setEmail(e.target.value);

  const handleChangePassword = (e: ChangeEvent<HTMLInputElement>) =>
    setPassword(e.target.value);

  const handleSubmit = async () => {
    try {
      setIsLoading(true);
      await SignInAction({
        email,
        password,
        onSuccess: (data) => {
          alert(data.message);
          localStorage.setItem("jwt", data.data.jwt);
          localStorage.setItem("username", data.data.account.username);
          router("/");
        },
        onError: () => alert("Sign In Fails..."),
      });
    } catch (error) {
      alert("Sign In Fails...!");
    } finally {
      setIsLoading(false);
    }
  };

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
        <h1 className="text-xl font-semibold">Sign In Page</h1>
        <p className="text-sm text-slate-500">Login with email and password</p>
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

        {/* Button */}
        <div>
          <button
            onClick={handleSubmit}
            disabled={isLoading}
            className="bg-lime-500 hover:bg-lime-700 text-white font-bold py-2 px-4 rounded"
          >
            Submit
          </button>
        </div>
      </section>
    </main>
  );
}
