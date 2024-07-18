"use client"

import React, { createContext, useContext, useEffect, useState } from "react";

import { User } from "@supabase/supabase-js";
import browserClient from "../supabase/browser-client";

interface UserContextType {
  isAuthroized: boolean;
  user: User | null;
  signUpWithEmailAndPassword: (
    email: string,
    password: string
  ) => Promise<void>;
  signInWithEmailAndPassword: (
    email: string,
    password: string
  ) => Promise<void>;
  signOut: () => Promise<void>;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [user, setUser] = useState<User | null>(null);
  const [isAuthroized, setIsAuthroized] = useState<boolean>(false);

  useEffect(() => {
    browserClient.auth.getSession().then((data) => {
      const { session } = data.data;
      setUser(session?.user || null);
    });
    const { data: authListener } = browserClient.auth.onAuthStateChange(
      (event, session) => {
        console.debug(event);
        setUser(session?.user || null);
      }
    );

    return () => {
      authListener.subscription.unsubscribe();
    };
  }, []);

  useEffect(() => {
    if (user) {
      setIsAuthroized(true);
    } else {
      setIsAuthroized(false);
    }
  }, [user]);

  const signUpWithEmailAndPassword = async (
    email: string,
    password: string
  ) => {
    const {
      data: { user },
      error,
    } = await browserClient.auth.signUp({ email, password });
    if (error) {
      throw error;
    }
    setUser(user);
  };

  const signInWithEmailAndPassword = async (
    email: string,
    password: string
  ) => {
    const {
      data: { user },
      error,
    } = await browserClient.auth.signInWithPassword({ email, password });
    if (error) {
      throw error;
    }
    setUser(user);
  };

  const signOut = async () => {
    await browserClient.auth.signOut();
    setUser(null);
  };

  return (
    <UserContext.Provider
      value={{
        isAuthroized,
        user,
        signUpWithEmailAndPassword,
        signInWithEmailAndPassword,
        signOut,
      }}
    >
      {children}
    </UserContext.Provider>
  );
};

export default function useAuth(): UserContextType {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error("useUser must be used within a UserProvider");
  }
  return context;
}
