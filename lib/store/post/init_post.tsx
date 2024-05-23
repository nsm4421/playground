"use client";

import { useCallback, useEffect, useRef } from "react";
import usePostState from "./post_state";
import axios from "axios";
import { NextEndPoint } from "@/lib/contant/end-point";
import { toast } from "react-toastify";
import { PostWithAuthor } from "@/lib/contant/post";

export default function InitPost() {
  const initState = useRef(false);
  const { page, size, addPosts } = usePostState();

  const fetchPosts = useCallback(async () => {
    await axios
      .get(NextEndPoint.fetchPosts, {
        params: {
          page,
          size,
        },
      })
      .then((res) => {
        addPosts(res.data.payload as PostWithAuthor[]);
      })
      .catch((error) => {
        console.error(error);
        toast.error("Fail to get posts!");
      });
  }, []);

  useEffect(() => {
    if (!initState.current) {
      fetchPosts();
    }
    initState.current = true;
  }, []);

  return <></>;
}
