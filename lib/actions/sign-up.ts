import { User } from "@supabase/supabase-js";

interface Props {
  email: string;
  password: string;
  onSuccess: (user: User) => void;
  onError: (error: any) => void;
}

export default async function signUpWithEmaiAndPasswordAction({
  email,
  password,
  onSuccess,
  onError,
}: Props) {
  console.debug(`sign up request email:${email} password:${password}`)
  await fetch("/api/auth/sign-up", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email, password }),
  })
    .then((res) => res.json())
    .then((user: User) => {
      onSuccess(user);
    })
    .catch((error) => {
      console.error(error);
      onError(error);
    });
}
