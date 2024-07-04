import Link from "next/link";
import SignUpButton from "./_signUpButton";

export default function SignUpPage() {
  return (
    <div className="flex justify-center items-center h-full">
      <section className="flex-col justify-center items-center h-1/2 w-1/2 text-center">
        <h1 className="w-full text-center mt-5 text-3xl font-bold">Sign Up</h1>
        <p className="mt-5">Let's Sign Up</p>
        <div className="mt-5">
          <SignUpButton provider="github" />
        </div>
        <Link href={"/auth/login"}>
          <p className="mt-3 text-slate-300 hover:text-rose-500">Alreay Have Account?</p>
        </Link>
      </section>
    </div>
  );
}
