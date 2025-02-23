import { Button } from "@/components/ui/button";
import { RoutePaths } from "@/lib/constant/route";
import Link from "next/link";

export default async function EntryPage() {
  return (
    <div className="flex h-screen w-screen">
      <main className="container mx-auto my-auto flex flex-col">
        <h1 className="text-5xl font-semibold mb-10">Karma</h1>

        <ul className="items-center">
          <li className="flex gap-x-5 mb-3">
            <h3 className="text-lg">Want to Create account?</h3>
            <Button className="hover:text-orange-500 cursor-pointer">
              <Link className="font-semibold" href={`${RoutePaths.signUp}`}>
                Sign Up
              </Link>
            </Button>
          </li>

          <li className="flex gap-x-5 items-center">
            <h3 className="text-lg">Already have account?</h3>
            <Button className="hover:text-orange-500 cursor-pointer">
              <Link className="font-semibold" href={`${RoutePaths.signIn}`}>
                Sign In
              </Link>
            </Button>
          </li>
        </ul>
      </main>
    </div>
  );
}
