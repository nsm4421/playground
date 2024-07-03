import { Button } from "../ui/button";
import { IoMdLogIn } from "react-icons/io";

export default function Navbar() {
  return (
    <nav className="w-screen flex items-center justify-between px-2 pt-2">
      <div className="flex items-center gap-3">
        <strong className="text-3xl">LOGO</strong>
      </div>
      <div>
        <ul className="flex">
          <li className="max-w-2xl">
            <Button variant="ghost">Menu1</Button>
          </li>
          <li className="max-w-2xl">
            <Button variant="ghost">Menu2</Button>
          </li>
          <li className="max-w-2xl">
            <Button variant="ghost">Menu3</Button>
          </li>
        </ul>
      </div>
      <Button size="icon" className="rounded-full text-white">
        <IoMdLogIn />
      </Button>
    </nav>
  );
}
