"use server";

import { ApiRoutes, RoutePaths } from "@/constant/route";
import { redirect } from "next/navigation";

export default async function onSignIn(
  prevState: { message: string | null },
  formData: FormData
) {
  let isSuccess = false;
  const validation = validate(formData);
  if (validation) {
    return validation;
  }
  try {
    const endPoint = `${process.env.NEXT_PUBLIC_BASE_URL}/${ApiRoutes.signIn.path}`;
    const res = await fetch(endPoint, {
      method: ApiRoutes.signIn.method,
      body: formData,
      credentials: "include",
    });
    console.debug(
      `sign-in request status code:${res.status}(${res.statusText})`
    );
    if (res.status === 403) {
      return { message: "username already exists" };
    }
    isSuccess = true;
    const json = await res.json();
    console.debug(json);
  } catch (error) {
    console.error(error);
    return { message: "sign up fails" };
  }
  if (isSuccess) {
    redirect(RoutePaths.home);
  }
  return { message: null };
}

function validate(formData: FormData) {
  const username = formData.get("username");
  const password = formData.get("password");
  if (!username) {
    return { message: "username is not given" };
  } else if (!password) {
    return { message: "password is not given" };
  }
  return null;
}
