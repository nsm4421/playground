"use client";

import { useCallback, useEffect, useRef } from "react";
import usePostState from "./post_state";
import axios from "axios";
import { NextEndPoint } from "@/lib/contant/end-point";
import { toast } from "react-toastify";
import { PostWithAuthor } from "@/lib/contant/post";

export default function InitPost() {
  const initState = useRef(false);
  const { page, size, posts, setIsEnd, setIsFetching, addPosts } =
    usePostState();

  const fetchPosts = useCallback(async (page: number) => {
    try {
      setIsFetching(true);
      await axios
        .get(NextEndPoint.fetchPosts, {
          params: {
            page,
            size,
          },
        })
        .then((res) => {
          const newPosts = res.data.payload as PostWithAuthor[];
          setIsEnd(newPosts.length < size);
          addPosts([...posts, ...newPosts]);
        })
        .catch((error) => {
          console.error(error);
          toast.error("Fail to get posts!");
        });
    } catch (error) {
      console.error(error);
      toast.error("Unknown error!");
    } finally {
      setIsFetching(false);
    }
  }, []);

  useEffect(() => {
    if (initState.current) {
      fetchPosts(page);
    } else {
      initState.current = true;
    }
  }, [page]);

  return <></>;
}
