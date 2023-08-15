import { Article } from "@/utils/model";
import { useEffect, useState } from "react";
import MyEditor from "../write/edit-article";
import { EditorState, convertFromRaw } from "draft-js";
import {
  Avatar,
  Badge,
  Box,
  Divider,
  Group,
  Paper,
  Title,
} from "@mantine/core";
import "react-draft-wysiwyg/dist/react-draft-wysiwyg.css";
import EmotionButton from "./emotion-button";

export default function ArticleContent(props: {
  id: string ;
  article: Article | null;
}) {
  const [editorState, setEditorState] = useState<EditorState | undefined>(
    undefined
  );

  // Get Article
  useEffect(() => {
    if (props.article?.content) {
      setEditorState(
        EditorState.createWithContent(
          convertFromRaw(JSON.parse(props.article?.content))
        )
      );
    }
  }, [props.article]);

  // On Error
  if (!props.article) {
    return (
      <>
        <h1>Faile to get Article</h1>
      </>
    );
  }

  return (
    <>
      <Paper shadow="md" m="sm" p="md" withBorder>
        <Group position="apart">
          {/* 제목 */}
          <Group>
            <Badge>Title</Badge>
            <Title order={6}>{props.article.title}</Title>
          </Group>
          {/* 작성자 */}
          <Badge
            pl={0}
            size="md"
            color="teal"
            radius="xl"
            leftSection={<Avatar size="sm" />}
          >
            {props.article.createdBy}
          </Badge>
        </Group>
      </Paper>

      <Paper shadow="md" m="sm" p="md" withBorder>
        <Badge pt="sm" pb="sm" mb="sm">
          Content
        </Badge>
        <Divider />
        {/* 본문 */}
        <Box p="sm" mb="md">
          {editorState && (
            <MyEditor readOnly={true} editorState={editorState} />
          )}
        </Box>
        <Divider />
        <Group position="apart">
          {/* 해시태그 */}
          <Box maw={400} pt="sm">
            {Array.from(props.article.hashtags).map((hashtag, idx) => (
              <Badge key={idx} color="green">
                #{hashtag}
              </Badge>
            ))}
          </Box>
          {/* 좋아요/싫어요 버튼 */}
          <EmotionButton id={props.id} />
        </Group>
      </Paper>
    </>
  );
}
