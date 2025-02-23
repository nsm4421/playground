"use client";

import PasswordIcon from "@/components/icon/password-icon";
import IdIcon from "@/components/icon/id-icon";
import Form from "next/form";
import ClearIcon from "@/components/icon/clear-icon";
import onSingIn from "../../../lib/action/sign-in-action";
import { RoutePaths } from "@/lib/constant/route";
import { useFormStatus } from "react-dom";
import { useActionState, useEffect } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";
import { useToast } from "@/lib/hooks/use-toast";

export default function SignInModal() {
  const router = useRouter();
  const [state, formAction] = useActionState(onSingIn, {
    message: null,
    isSuccess: false,
  });
  const { pending } = useFormStatus();
  const { toast } = useToast();

  useEffect(() => {
    console.debug(`sign in request ${state.isSuccess ? "success" : "fail"}`);
    if (state.isSuccess) {
      toast({
        title: "success",
        description: "Sign In Success",
        duration: 1500,
      });
      router.replace(RoutePaths.home);
    }
  }, [state.isSuccess]);

  return (
    <div className="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl shadow-xl max-w-md w-full p-6 relative">
        <header className="flex justify-between items-center mb-3">
          <h2 className="text-xl font-semibold text-gray-800 mb-3">Sign In</h2>
          <a href={RoutePaths.entry}>
            <ClearIcon />
          </a>
        </header>

        {state.message && (
          <div className="my-3 py-2 px-3 bg-rose-200 rounded-lg ">
            <p className="text-red-600 text-sm">{state.message}</p>
          </div>
        )}

        <Form action={formAction}>
          <ul className="flex flex-col gap-y-3">
            <li className="flex items-center gap-x-3">
              <label htmlFor="id" className="text-sm text-slate-700">
                <IdIcon clsName="w-5" />
              </label>
              <Input
                id="username"
                name="username"
                placeholder="username"
                required
              />
            </li>
            <li className="flex items-center gap-x-3">
              <label htmlFor="password" className="text-sm text-slate-700">
                <PasswordIcon clsName="w-5" />
              </label>
              <Input
                id="password"
                name="password"
                required
                placeholder="password"
                type="password"
              />
            </li>
          </ul>
          <div className="flex gap-x-3 justify-end mt-5">
            <Button disabled={pending} type="submit">
              Submit
            </Button>
          </div>
        </Form>
      </div>
    </div>
  );
}
