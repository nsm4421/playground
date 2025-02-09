import SignInModal from "../../_components/sign-in-modal";

// intercept router에서 렌더링하므로, 해당 컴퍼넌트가 보일 때는 새로고침되는 경우 뿐임
export default function SignInPage() {
  return <SignInModal />;
}
