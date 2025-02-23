"use server";

import { signIn } from "@/auth";

export default async function onSignIn(
  prevState: { message: string | null; isSuccess: boolean },
  formData: FormData
) {
  const validation = validate(formData);
  if (validation) {
    return validation;
  }
  try {
    await signIn("credentials", {
      username: formData.get("username"),
      password: formData.get("password"),
      redirect: false,
    });
    console.debug("sign in request success");
    return { message: null, isSuccess: true };
  } catch (error) {
    console.error(error);
    return { message: "sign up fails", isSuccess: false };
  }
}

function validate(formData: FormData) {
  const username = formData.get("username");
  const password = formData.get("password");
  if (!username) {
    return { message: "username is not given", isSuccess: false };
  } else if (!password) {
    return { message: "password is not given", isSuccess: false };
  }
  return null;
}
