import Link from "next/link";
import LoginButton from "./_loginButton";

export default function LoginPage() {
  return (
    <div className="flex justify-center items-center h-full">
      <section className="flex-col justify-center items-center h-1/2 w-1/2 text-center">
        <h1 className="w-full text-center mt-5 text-3xl font-bold">Login</h1>
        <p className="mt-5">Let's Login</p>
        <div className="mt-5">
          <LoginButton provider="github" />
        </div>
        <Link href={"/auth/signup"}>
          <p className="mt-3 text-slate-300 hover:text-rose-500">Want Create Account?</p>
        </Link>
      </section>
    </div>
  );
}
