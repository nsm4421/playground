import { Routes, Route, Navigate } from "react-router-dom";
import EntryPage from "./pages/EntryPage";
import SignInPage from "./pages/SignInPage";
import SignUpPage from "./pages/SignUpPage";
import Navbar from "./components/Navbar";
import useAuth from "./hook/use-auth";
import ChatPage from "./pages/ChatPage";

function App() {
  const { isAuthenticated } = useAuth();

  return (
    <div className="text-black dark:text-white h-screen">
      <Navbar />
      <div className="container mx-auto px-1">
        <Routes>
          <Route path="/" element={<EntryPage />}></Route>
          <Route path="/auth/sign-in" element={<SignInPage />}></Route>
          <Route path="/auth/sign-up" element={<SignUpPage />}></Route>
          <Route path="/chat" element={<ChatPage />}></Route>
          {/* Redirect */}
          <Route path="*" element={<Navigate to={"/"} />}></Route>
        </Routes>
      </div>
    </div>
  );
}

export default App;
