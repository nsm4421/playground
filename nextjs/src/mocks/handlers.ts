import { http, HttpResponse } from "msw";
import { faker } from "@faker-js/faker";

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL;

const genDate = () => {
  return faker.date
    .between({
      from: new Date(Date.now() - 10),
      to: Date.now(),
    })
    .toLocaleTimeString();
};

export const handlers = [
  // http.get(`${baseUrl}${ApiRoutes.fetchFeedRecommends.path}`, () => {
  //   console.log("mocking fetch feed recommend");
  //   return HttpResponse.json<Feed[]>(feeds, {
  //     status: 200,
  //     headers: {
  //       "Set-Cookie": "connect.sid=;HttpOnly;path=/;Max-Age=0",
  //     },
  //   });
  // }),
];
