"use client";

import { PostData } from "@/util/model";
import { useEffect, useState } from "react";
import PostComponent from "./post-component";

export default function PostListComponent() {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [posts, setPosts] = useState<PostData[]>([]);

  const getPosts = async () => {
    setIsLoading(true);
    await fetch("/api/posts")
      .then((res) => res.json())
      .then((data) => setPosts(data.data))
      .finally(() => setIsLoading(false));
  };

  const deletePost = async (_id: string) => {
    fetch("/api/post/delete", {
      method: "POST",
      body: JSON.stringify({ _id }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.success) {
          setPosts([...posts].filter((post) => post._id !== _id));
          return;
        }
        alert(data.message);
      });
  };

  useEffect(() => {
    getPosts();
  }, []);

  // on loading
  if (isLoading) {
    return (
      <>
        <h1>Loading...</h1>
      </>
    );
  }

  // show post list
  return (
    <>
      {posts &&
        posts.map((post, idx) => (
          <PostComponent key={idx} post={post} deletePost={deletePost} />
        ))}
    </>
  );
}
