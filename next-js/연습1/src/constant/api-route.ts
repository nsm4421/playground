type ApiRoute = {
  method: "GET" | "POST" | "PUT" | "DELETE";
  path: string;
  queryKeys?: string[];
};

export const ApiRoute = {
  fetchMessages: {
    method: "POST",
    path: "/api/auth/sign-in",
  } as ApiRoute,
};
