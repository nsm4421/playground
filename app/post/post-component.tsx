import { PostData } from "@/util/model";
import Link from "next/link";
import DeletePostButton from "./delete-post-button";

export default function PostComponent(props:{post:PostData, deletePost:Function}) {
  return props.post&&(
    <div>
      <Link href={`/post/${props.post._id}`}>
        <h3>{props.post.title}</h3>
      </Link>
      <p>{props.post.content}</p>
      <Link href={`/post/edit/${props.post._id}`}>
        <button>Edit Post</button>
      </Link>
      <DeletePostButton _id={props.post._id} deletePost={props.deletePost}/>
      <hr/>
    </div>
  )
}
