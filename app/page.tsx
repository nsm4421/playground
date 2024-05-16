import LogoutButton from "@/components/auth/logout-button";
import UserButton from "@/components/auth/user-button";
import InitAuth from "@/lib/store/auth/init_auth";

export default function Home() {
  return (
    <main>
      HOME
      <UserButton />
      <LogoutButton />
      <InitAuth />
    </main>
  );
}
