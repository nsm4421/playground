import Image from "next/image";
import Link from "next/link";

export default function NavBarComponent() {
  return (
    <nav className="nav-bar">
      <div className="mx-2">
        <Link href="/" className="flex items-center gap-4">
          <Image src="/logo.svg" alt="logo" width={28} height={28} />
          <p className="max-w-xs:hidden text-2xl font-extrabold">Karma</p>
        </Link>
      </div>
    </nav>
  );
}
