import { Accordion, Badge } from "@mantine/core";
import EditArticle from "./edit-article";
import { EditorState } from "draft-js";
import { Dispatch, SetStateAction } from "react";

export default function ArticleContentAccrodian({
  editorState,
  setEditorState,
}: {
  editorState: EditorState | undefined;
  setEditorState: Dispatch<SetStateAction<EditorState | undefined>>;
}) {
  return (
    <Accordion.Item value="content">
      <Accordion.Control>
        <Badge pt="sm" pb="sm" mt="sm" mb="sm">
          Content
        </Badge>
      </Accordion.Control>
      <Accordion.Panel>
        {editorState != null && (
          <EditArticle
            editorState={editorState}
            onEditorStateChange={setEditorState}
            readOnly={false}
          />
        )}
      </Accordion.Panel>
    </Accordion.Item>
  );
}
