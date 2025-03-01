import { ApiRoutes } from "@/lib/constant/route";
import { User } from "@/lib/types/user";
import { http, HttpResponse } from "msw";
import { faker } from "@faker-js/faker";
import { Feed } from "../types/feed";

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL;

const genDate = () => {
  return faker.date
    .between({
      from: new Date(Date.now() - 10),
      to: Date.now(),
    })
    .toLocaleTimeString();
};
const users: User[] = Array.from({ length: 100 }, (_, i) => ({
  id: `user${i}`,
  username: `username${i}`,
  image: faker.image.avatar(),
  createdAt: genDate(),
}));

const feeds: Feed[] = Array.from({ length: 100 }, (_, i) => ({
  id: `${i}`,
  user: users[i],
  content: `feed content ${i}`,
  images: [
    faker.image.urlPicsumPhotos(),
    faker.image.urlPicsumPhotos(),
    faker.image.urlPicsumPhotos(),
  ],
  createdAt: genDate(),
}));

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

  http.get(`${baseUrl}${ApiRoutes.fetchFeedRecommends.path}`, () => {
    console.log("mocking fetch feed recommend");
    return HttpResponse.json<Feed[]>(feeds, {
      status: 200,
      headers: {
        "Set-Cookie": "connect.sid=;HttpOnly;path=/;Max-Age=0",
      },
    });
  }),
];
