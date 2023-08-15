import { Dispatch, SetStateAction } from "react";
import { EditorState } from "draft-js";
import dynamic from "next/dynamic";
import { EditorProps } from "react-draft-wysiwyg";

const Editor = dynamic<EditorProps>(
  () => import("react-draft-wysiwyg").then((module) => module.Editor),
  {
    ssr: false,
  }
);

export default function MyEditor({
  editorState,
  readOnly = false,
  onEditorStateChange,
}: {
  editorState: EditorState;
  readOnly?: boolean;
  onEditorStateChange?: Dispatch<SetStateAction<EditorState | undefined>>;
}) {
  return (
    <Editor
      readOnly={readOnly}
      toolbarHidden={readOnly}
      editorState={editorState}
      placeholder={
        "when editing mode changed, content is cleared " +
        "\n" +
        "character of content is less than 3000"
      }
      // localization={{
      //   local: "ko",
      // }}
      onEditorStateChange={onEditorStateChange}
    />
  );
}
