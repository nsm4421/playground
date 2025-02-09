import { ReactNode } from "react";

interface Props {
  children: ReactNode;
  modal: ReactNode;
}

/**
 * @param children
 * @param modal
 * @ParallelRoute EntryPage에서 로그인 버튼 클릭 시, 라우팅 경로가 다른 두 페이지(EntryPage, ModalPage)를 동시에 띄움
 * @InterceptRoute "auth" 경로에 컴퍼넌트 렌더링하지 않고, "@modal/(.auth) 경로의 컴퍼넌트 먼저 렌더링. 단, 새로고침 시에 "auth" 경로의 컴퍼넌트 렌더링
 */
export default async function EntryPageLayout({ children, modal }: Props) {
  return (
    <>
      {children}
      {modal}
    </>
  );
}
