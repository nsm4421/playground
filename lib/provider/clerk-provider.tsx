import { ClerkProvider } from "@clerk/nextjs";

interface Props {
  children: React.ReactNode;
}

export default function ClerkProviderWrapper(props: Props) {
  return <ClerkProvider>{props.children}</ClerkProvider>;
}
