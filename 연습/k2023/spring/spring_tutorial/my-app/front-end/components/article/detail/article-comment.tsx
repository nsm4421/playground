import {
  Accordion,
  Avatar,
  Badge,
  Box,
  Button,
  Divider,
  Grid,
  Loader,
  Paper,
  Text,
  TextInput,
} from "@mantine/core";
import axios from "axios";
import { ChangeEvent, useEffect, useState } from "react";
import PagingBar from "../list/pagination-bar";
import { parseLocalDateTimeInKoreanTime } from "@/utils/date-util";
import { Comment } from "@/utils/model";

export default function ArticleComment(props: { id: string }) {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [comments, setComments] = useState<Comment[]>([]);
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [totalPages, setTotalpages] = useState<number>(1);

  const getComments = async () => {
    setIsLoading(true);
    await axios
      .get(
        `http://localhost:8080/api/comment?article-id=${props.id}&page=${
          pageNumber - 1
        }`
      )
      .then((res) => res.data.data)
      .then((data) => {
        setComments([...data.content]);
        setTotalpages(data.totalPages);
      })
      .catch((err) => {
        console.error(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  const modifyComment = async () => {};

  const deleteComment = async () => {};

  useEffect(() => {
    getComments();
  }, [pageNumber]);

  return (
    <Box>
      {/* 댓글입력 */}
      <Paper p="sm" shadow="md" m="sm" withBorder>
        <CommentInput id={props.id} callback={getComments} />
      </Paper>

      {/* 댓글보기 */}
      <Paper shadow="md" ml="sm" mr="sm" withBorder>
        <Accordion defaultValue="comments">
          <Accordion.Item value="comments">
            <Accordion.Control>
              <Badge color="green">Comments</Badge>
            </Accordion.Control>

            <Accordion.Panel>
              {comments &&
                comments.map((c, idx) => (
                  <Box key={idx} mb="sm">
                    <ParentComment comment={c} />
                  </Box>
                ))}

              {/* 페이징바 */}
              <Grid justify="center" align="center" mt="sm" mb="sm">
                <PagingBar
                  pageNumber={pageNumber}
                  setPageNumber={setPageNumber}
                  totalPages={totalPages}
                />
              </Grid>
            </Accordion.Panel>
          </Accordion.Item>
        </Accordion>
      </Paper>
    </Box>
  );
}

// 댓글 입력창
function CommentInput({
  id,
  parentCommentId,
  callback,
}: {
  id: number | string;
  parentCommentId?: number | string;
  callback?: Function;
}) {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [comment, setComment] = useState<string>("");
  const [errorMessage, setErrorMessage] = useState<string>("");
  const handleComment = (e: ChangeEvent<HTMLInputElement>) => {
    setErrorMessage("");
    setComment(e.target.value);
  };

  const submitComment = async () => {
    const token = await localStorage.getItem("token");
    if (!token) {
      alert("Need to login first");
      return;
    }
    if (!comment) {
      setErrorMessage("comment is blank");
      return;
    }
    setIsLoading(true);
    await axios
      .post(
        "http://localhost:8080/api/comment",
        {
          articleId: id,
          parentCommentId: parentCommentId,
          content: comment,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      )
      // 댓글 등록 성공시
      .then(() => {
        setComment("");
        if (callback) {
          callback();
        }
      })
      .catch((err) => {
        console.error(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <Box>
      <Badge mb="sm">Comment</Badge>
      <TextInput
        maw="95%"
        variant="filled"
        placeholder="Comment"
        value={comment}
        onChange={handleComment}
        error={errorMessage}
        rightSection={
          isLoading ? (
            <Loader size="xs" />
          ) : (
            <Button onClick={submitComment} disabled={isLoading}>
              Submit
            </Button>
          )
        }
      />
    </Box>
  );
}

function ParentComment({ comment }: { comment: Comment }) {
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [childComments, setChildComments] = useState<Comment[]>([]);
  const handleIsOpen = () => {
    setIsOpen(!isOpen);
    if (isOpen) {
      getChildComments();
    }
  };
  const getChildComments = async () => {
    setIsLoading(true);
    await axios
      .get(
        `http://localhost:8080/api/comment?article-id=${comment.articleId}&parent-comment-id=${comment.id}`
      )
      .then((res) => res.data)
      .then((data) => {
        setChildComments([...data.data.content]);
      })
      .catch((err) => {
        console.error(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <Box>
      <Grid p="sm" justify="space-between">
        <Grid.Col span={1}>
          <Grid justify="center" align="center">
            {/* 유저 */}
            <Avatar />
            <Badge size="md" color="teal" radius="xl">
              {comment.username}
            </Badge>
          </Grid>
        </Grid.Col>

        <Grid.Col span="auto">
          <Text>{comment.content}</Text>
        </Grid.Col>

        <Grid.Col span={2}>
          <Text color="gray" size="sm">
            {parseLocalDateTimeInKoreanTime(comment.createdAt)}
          </Text>
          <Button variant="subtle" onClick={handleIsOpen} disabled={isLoading}>
            {isOpen ? "Close" : "Open"}
          </Button>
        </Grid.Col>
      </Grid>
      
      {isOpen && (
        <Box ml="lg" mr="lg" pl="lg" pr="lg">
          <CommentInput id={comment.articleId} parentCommentId={comment.id} callback={getChildComments}/>
          <Paper>
            {childComments.map((c, i) => (
              <ChildComment key={i} comment={c} />
            ))}
          </Paper>          
        </Box>
      )}
      <Divider mt="sm" mr="lg" ml="lg" pr="lg" pl="lg" mb="sm"/>
    </Box>
  );
}

function ChildComment({
  comment: childComment
}: {
  comment: Comment;
}) {
  return (
    <Grid justify="space-between" mt="sm">
      <Grid.Col span={1}>
        <Grid justify="center" align="center">
          {/* 유저 */}
          <Avatar />
          <Badge size="md" color="teal" radius="xl">
            {childComment.username}
          </Badge>
        </Grid>
      </Grid.Col>

      <Grid.Col span="auto">
        <Text>{childComment.content}</Text>
      </Grid.Col>

      <Grid.Col span={2}>
        <Text color="gray" size="sm">
          {parseLocalDateTimeInKoreanTime(childComment.createdAt)}
        </Text>
      </Grid.Col>
    </Grid>
  );
}
