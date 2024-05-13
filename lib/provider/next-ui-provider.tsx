import { NextUIProvider } from "@nextui-org/react";

interface Props {
  children: React.ReactNode;
}

export function NextUiProviderWrapper(props: Props) {
  return <NextUIProvider>{props.children}</NextUIProvider>;
}
