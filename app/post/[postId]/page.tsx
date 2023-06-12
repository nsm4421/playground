import CommentComponent from "./comment-component";
import PostContentComponent from "./post-content-component";

export default async function Detail() {

  return (
    <>
      <PostContentComponent />
      <CommentComponent/>
    </>
  );
}
