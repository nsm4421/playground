import Link from "next/link";
import SignInForm from "./_form";

export default function SignInPage() {
  return (
    <main className="px-5 flex flex-col h-full">
      <div className="mx-auto my-auto w-10/12">
        <h1 className="text-xl">Sign In</h1>
        <p className="text-sm text-slate-700 mt-2">
          you can sign in with email and password
        </p>
        <section className="mx-3 my-5 p-3">
          <SignInForm />
        </section>

        <hr className="mx-8 border-gray-300" />

        <div className="mx-3 my-5 p-3 flex justify-center">
          <Link href="/sign-up">
            <span className="hover:text-orange-500">
              Want to create account?
            </span>
          </Link>
        </div>
      </div>
    </main>
  );
}
