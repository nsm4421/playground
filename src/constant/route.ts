export enum RoutePaths {
  // un-authorized
  entry = "/",
  signUp = "/auth/sign-up",
  signIn = "/auth/sign-in",

  // authorized
  home = "/home",
  search = "/search",
  messages = "/messages",
  composeFeed = "compose/feed",
  profile = "profile",
}

type ApiRoute = {
  method: "GET" | "POST" | "PUT" | "DELETE";
  path: string;
};

export const ApiRoutes = {
  signIn: {
    method: "POST",
    path: "/api/sign-in",
  } as ApiRoute,
  signUp: {
    method: "POST",
    path: "/api/sign-up",
  } as ApiRoute,
  signOut: {
    method: "POST",
    path: "/api/sign-out",
  } as ApiRoute,
};
