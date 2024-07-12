import AuthForm from "@/components/auth/auth-form";
import InitAuth from "@/lib/store/auth/init-auth";


export default function Page() {
  return (
    <>
      <AuthForm />
      <InitAuth />
    </>
  );
}
