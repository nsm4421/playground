"use client";

import { signIn } from "next-auth/react";
import Link from "next/link";

export default function NotAuthorizedComponent() {
  const handleSignIn = () => {
    signIn();
  };
  return (
    <div className="h-full">
      <section className="bg-white dark:bg-gray-900">
        <div className="py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16">
          <h1 className="mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
            Need to login
          </h1>
          <p className="mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 lg:px-48 dark:text-gray-400">
            To See this page, need to login
          </p>
          <div className="flex flex-col space-y-4 sm:flex-row sm:justify-center sm:space-y-0 sm:space-x-4">
            <div className="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-white rounded-lg bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 dark:focus:ring-green-900">
              <Link href="/auth/register">Register</Link>
            </div>
            <div
              onClick={handleSignIn}
              className="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-white rounded-lg bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:bg-blue-300 dark:focus:bg-blue-900"
            >
              Sign In
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
