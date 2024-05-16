import AuthForm from "@/components/auth/auth-form";
import InitAuth from "@/lib/store/auth/init_auth";

export default function Page() {
  return (
    <>
      <AuthForm />
      <InitAuth />
    </>
  );
}
