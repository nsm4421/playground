import { SetupWorker, setupWorker } from "msw/browser";
import { handlers } from "./handlers";

const worker: SetupWorker = setupWorker(...handlers);

export default worker;
