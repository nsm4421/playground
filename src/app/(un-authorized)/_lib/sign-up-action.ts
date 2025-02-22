"use server";

import { ApiRoutes, RoutePaths } from "@/constant/route";
import { redirect } from "next/navigation";

export default async function onSignUp(
  prevState: { message: string | null },
  formData: FormData
) {
  let isSuccess = false;
  const validation = validate(formData);
  if (validation) {
    return validation;
  }
  try {
    const endPoint = `${process.env.NEXT_PUBLIC_BASE_URL}/${ApiRoutes.signUp.path}`;
    const res = await fetch(endPoint, {
      method: ApiRoutes.signUp.method,
      body: formData,
      credentials: "include",
    });
    console.debug(
      `sign-up request status code:${res.status}(${res.statusText})`
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
  const passwordConfirm = formData.get("password-confirm");
  const nickname = formData.get("password-confirm");
  if (!username) {
    return { message: "username is not given" };
  } else if (!password) {
    return { message: "password is not given" };
  } else if (!passwordConfirm) {
    return { message: "password confirm is not given" };
  } else if (password !== passwordConfirm) {
    return { message: "passwords are not matched" };
  } else if (!nickname) {
    return { message: "nickname is not given" };
  }
  return null;
}
