import SignInButton from "./sign_in_button";

export default function LoginMenu() {
  return (
    <div className="w-full h-full">
      <div className="mt-5">
        <h1 className="text-xl font-bold">Login Page</h1>
        <p className="text-slate-500 text-sm">
          you can login with google and github account
        </p>
      </div>

      <section className="mt-10">
        <ul>
          <li className="w-1/2 mt-2">
            <SignInButton
              clsName="bg-blue-500"
              provider={"google"}
              label="구글 계정으로 로그인하기"
            />
          </li>

          <li className="w-1/2 mt-2">
            <SignInButton
              clsName="bg-slate-400"
              varaint="outline"
              provider={"github"}
              label="깃허브 계정으로 로그인하기"
            />
          </li>
        </ul>
      </section>
    </div>
  );
}
