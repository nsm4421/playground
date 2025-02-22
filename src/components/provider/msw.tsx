import { handlers } from "@/mocks/handlers";
import { SetupWorker } from "msw/browser";
import { ReactNode, Suspense, use } from "react";

interface Props {
  children: ReactNode;
}

export default function MSWProvider({ children }: Props) {
  return (
    <Suspense fallback={null}>
      <MSWProviderWrapper>{children}</MSWProviderWrapper>
    </Suspense>
  );
}

function MSWProviderWrapper({ children }: Props) {
  const promise =
    typeof window !== "undefined"
      ? import("@/mocks/browser").then(async ({ default: worker }) => {
          if (process.env.NODE_ENV == "production") {
            return;
          }
          await worker.start({
            onUnhandledRequest(req, print) {
              if (req.url.includes("_next")) {
                return;
              }
              print.warning();
            },
          });
          worker.use(...handlers);
          (module as any).hot?.dispose(() => {
            worker.stop();
          });
          console.log(worker.listHandlers());
        })
      : Promise.resolve();
  use(promise);
  return children;
}
