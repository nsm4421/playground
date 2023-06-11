import PostListComponent from "./post-list-component";

export default async function Post() {
  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg">
      <PostListComponent />
    </div>
  );
}
