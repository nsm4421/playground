"use server";

import { ApiRoutes } from "@/lib/constant/route";

export default async function onSignUp(
  prevState: { message: string | null; isSuccess: boolean },
  formData: FormData
) {
  const validation = validate(formData);
  if (validation) {
    return { ...validation, isSuccess: false };
  }
  try {
    const endPoint = `${process.env.NEXT_PUBLIC_BASE_URL}${ApiRoutes.signUp.path}`;
    console.debug(`[onSignUp]end-point:${endPoint}`);
    const res = await fetch(endPoint, {
      method: ApiRoutes.signUp.method,
      body: formData,
      credentials: "include",
    });
    console.debug(`[onSignUp]status-code:${res.status}(${res.statusText}`);
    if (res.status === 403) {
      return { message: "username already exists", isSuccess: false };
    }
    return { message: null, isSuccess: true };
  } catch (error) {
    console.error(error);
    return { message: "sign up fails", isSuccess: false };
  }
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
