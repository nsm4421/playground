import "next-auth/jwt";

// Referece : https://next-auth.js.org/getting-started/typescript

declare module "next-auth" {
  interface Session {
    user: {
      id?: string; // when user sign up, user information is saved as docuemnt in "users" collection. its document id
      name?: string;
      email?: string;
      image?: string;
      role?: ROLE;
    };
  }
}
