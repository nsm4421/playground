import { User } from "@supabase/supabase-js";

interface Props {
  email: string;
  password: string;
  onSuccess: (user: User) => void;
  onError: (error: any) => void;
}

interface Body {
  user?: User;
  error?: {
    code: String;
    name: String;
    status: number;
  };
}

export default async function signInWithEmaiAndPasswordAction({
  email,
  password,
  onSuccess,
  onError,
}: Props) {
  console.debug(`sign in request email:${email} password:${password}`);
  await fetch("/api/auth/sign-in", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email, password }),
  })
    .then((res) => res.json())
    .then((data: Body) => {
      if (data?.user) {
        onSuccess(data.user);
      } else {
        onError(data.error);
      }
    })
    .catch(onError);
}
