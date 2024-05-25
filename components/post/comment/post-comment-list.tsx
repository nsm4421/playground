import { PostCommentWithAuthor, PostWithAuthor } from "@/lib/contant/post";
import dateFormatUtil from "@/lib/util/date-format-util";
import { Avatar } from "@nextui-org/react";

interface Props {
  post: PostWithAuthor;
  comments: PostCommentWithAuthor[];
}

export default function PostCommentList(props: Props) {
  return (
    <section className="shadow-lg p-2 ">
      <ul>
        {props.comments.map((comment, index) => (
          <li key={index} className="mt-3">
            <div className="flex justify-between items-center">
              <div className="flex justify-start items-center gap-x-3">
                {/* 작성자 */}
                <Avatar
                  src={comment.author.profile_image}
                  name={comment.author.nickname}
                />

                {/* 댓글 */}
                <p className="text-lg font-semibold">{comment.content}</p>
              </div>

              {/* 작성시간 */}
              {comment.created_at && (
                <span className="text-sm text-slate-500">
                  {dateFormatUtil(comment.created_at)}
                </span>
              )}
            </div>
          </li>
        ))}
      </ul>
    </section>
  );
}
