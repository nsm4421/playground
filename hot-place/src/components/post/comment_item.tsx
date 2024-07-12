import CommentModel from "@/data/model/comment_model";

interface CommentItemProps {
    comment : CommentModel
}

export default function CommentItem({comment}:CommentItemProps){
    return <div>
        <span>comment : </span>
        {comment.content}
        {comment.createdAt && comment.createdAt.toString()}
    </div>
}