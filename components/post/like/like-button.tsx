"use client";

import { NextEndPoint } from "@/lib/contant/end-point";
import { PostWithAuthor } from "@/lib/contant/post";
import { faHeart } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import axios from "axios";
import { useEffect, useState } from "react";

interface Props {
  post: PostWithAuthor;
}

export default function InitLike({ post }: Props) {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [isError, setIsError] = useState<boolean>(false);
  const [isLike, setIsLike] = useState<boolean>(false);

  useEffect(() => {
    // TODO : 맨 처음 좋아요 여부 가져오는 쿼리 최적화
    (async () => {
      try {
        setIsLoading(true);
        await axios
          .get(NextEndPoint.getLike, {
            params: {
              post_id: post.id,
            },
          })
          .then((res) => res.data.payload)
          .then((payload) => {
            setIsLike(payload);
          })
          .catch((error) => {
            console.error(error);
            setIsError(true);
          });
      } catch (error) {
        console.error(error);
        setIsError(true);
      } finally {
        setIsLoading(false);
      }
    })();
  }, []);

  const handleLike = async () => {
    if (isError || isLoading) {
      return;
    }
    try {
      setIsLoading(true);
      const endPoint = `${NextEndPoint.likeOnPost}?post_id=${post.id}`;
      if (isLike) {
        await axios.post(endPoint).then(() => setIsLike(false));
      } else {
        await axios.delete(endPoint).then(() => setIsLike(true));
      }
    } catch (error) {
      console.error(error);
      setIsError(true);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <button
      disabled={isLoading || isError}
      className={isLike ? "text-rose-500" : "text-slate-500"}
      onClick={handleLike}
    >
      <FontAwesomeIcon icon={faHeart} />
    </button>
  );
}
