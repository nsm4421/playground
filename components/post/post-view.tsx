import DOMPurify from "dompurify";
import "react-quill/dist/quill.core.css"

interface Props {
  htmlString: string;
}

export default function PostView(props: Props) {
  return (
    <section
      aria-label="quill-view"
      dangerouslySetInnerHTML={{
        __html: DOMPurify.sanitize(props.htmlString),
      }}
    />
  );
}
