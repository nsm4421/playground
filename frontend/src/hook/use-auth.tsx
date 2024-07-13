import { createContext, ReactNode, useEffect, useState } from "react";
import {
  SignInSuccessResponse,
  SignUpSuccessResponse,
} from "../model/auth-model";
import axios from "axios";
import { EndPoint } from "../config/end-point";

interface SignUpProps {
  email: string;
  password: string;
  onSuccess?: () => void;
  onError?: () => void;
}

interface SignInProps {
  email: string;
  password: string;
  onSuccess?: () => void;
  onError?: () => void;
}

export default function useAuth() {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);

  const signUp = async ({
    email,
    password,
    onSuccess,
    onError,
  }: SignUpProps) => {
    await axios
      .post(EndPoint.signup, { email, password })
      .then((res) => res.data as SignUpSuccessResponse)
      .then((data) => {
        sessionStorage.setItem("token", data.data);
      })
      .then(onSuccess)
      .catch(onError);
  };

  const signIn = async ({
    email,
    password,
    onSuccess,
    onError,
  }: SignInProps) => {
    await axios
      .post(EndPoint.signin, { email, password })
      .then((res) => res.data as SignInSuccessResponse)
      .then((data) => {
        console.log(data)
        sessionStorage.setItem("token", data.data.jwt);
        localStorage.setItem("account", JSON.stringify(data.data.account));
        setIsAuthenticated(true);
      })
      .then(onSuccess)
      .catch(onError);
  };

  const signOut = () => {
    sessionStorage.removeItem("token");
    localStorage.removeItem("account");
  };

  const getJwt = () => sessionStorage.getItem("token")

  const getAccount = () => localStorage.getItem("account")

  useEffect(() => {
    if (getJwt() && getAccount()) {
      setIsAuthenticated(true);
    }
  }, []);

  return { isAuthenticated, signIn, signUp, signOut };
}
