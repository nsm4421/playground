import { ApiRoutes } from "@/lib/constant/route";
import { User } from "@/lib/types/user";
import { http, HttpResponse } from "msw";
import { faker } from "@faker-js/faker";

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL;
const users: User[] = [
  { id: "test1", username: "test1", image: "https://picsum.photos/200" },
  { id: "test2", username: "test2", image: "https://picsum.photos/200" },
  { id: "test3", username: "test3", image: faker.image.avatar() },
];

export const handlers = [
  http.post(`${baseUrl}${ApiRoutes.signIn.path}`, () => {
    console.log("mocking login");
    return HttpResponse.json(users[0], {
      headers: {
        "Set-Cookie": "connect.sid=msw-cookie;HttpOnly;path=/",
      },
      status: 200,
    });
  }),
  http.post(`${baseUrl}${ApiRoutes.signUp.path}`, () => {
    console.log("mocking register");
    return HttpResponse.json(users[0], {
      headers: {
        "Set-Cookie": "connect.sid=msw-cookie;HttpOnly;path=/",
      },
      status: 200,
    });
  }),
  http.post(`${baseUrl}${ApiRoutes.signOut.path}`, () => {
    console.log("mocking logout");
    return new HttpResponse(null, {
      headers: {
        "Set-Cookie": "connect.sid=;HttpOnly;path=/;Max-Age=0",
      },
      status: 200,
    });
  }),
];
