import { Link } from "react-router-dom";
import useAuth from "../hook/use-auth";

export default function Navbar() {
  const { isAuthenticated } = useAuth();

  return (
    <nav className="py-2 rounded-lg bg-slate-200 dark:bg-slate-700">
      <div className="container mx-auto flex justify-between">
        <div>
          <h1 className="text-2xl font-extrabold hover:text-orange-500">
            <Link to="/">Karma</Link>
          </h1>
        </div>
        {isAuthenticated ? (
          <div>
            <ul className="flex gap-x-5">
              <li className="hover:text-orange-500">
                <Link to={"/chat"}>Chat</Link>
              </li>
            </ul>
          </div>
        ) : (
          <div>
            <ul className="flex gap-x-5">
              <li className="hover:text-orange-500">
                <Link to={"/auth/sign-up"}>Sign Up</Link>
              </li>
              <li className="hover:text-orange-500">
                <Link to={"/auth/sign-in"}>Sign In</Link>
              </li>
            </ul>
          </div>
        )}
      </div>
    </nav>
  );
}
