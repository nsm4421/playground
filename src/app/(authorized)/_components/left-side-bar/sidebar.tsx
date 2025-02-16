import Logo from "../logo";
import HomeNav from "./home-nav";
import LogoutButton from "./logout-button";

export default function LeftSideBar() {
  return (
    <section className="h-full flex items-end flex-col gap-y-2">
      <div className="flex w-[300px]">
        <Logo />
      </div>
      <div className="w-[300px]">
        <HomeNav />
      </div>
      <div className="bg-slate-100 rounded-lg px-3 py-2 w-[300px]">
        <LogoutButton label="Logout" />
      </div>
    </section>
  );
}
