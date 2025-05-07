import { useState } from "react";
import { EditorState, convertToRaw } from "draft-js";
import "react-draft-wysiwyg/dist/react-draft-wysiwyg.css";
import { Accordion, Box, Button, Container, Grid, Group, Title } from "@mantine/core";
import ArticleTitleAccordian from "@/components/article/write/article-title-accordian";
import ArticleContentAccrodian from "@/components/article/write/article-content-accordian";
import ArticleHashtagAccordian from "@/components/article/write/article-hashtag-accordian";
import { useRouter } from "next/router";

export default function WriteArticle() {
  const router = useRouter();
  const [title, setTitle] = useState<string>("");
  const [hashtags, setHashtags] = useState<string[]>([""]);

  const [editorState, setEditorState] = useState<EditorState | undefined>(
    EditorState.createEmpty()
  );
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleGoToArticlePage = () => {
    router.push("/article")
  }

  const handleSubmit = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      alert("You need to login first");
      router.push("/api/auth/login");
      return;
    }
    if (!editorState) {
      alert("Edit State Error");
      return;
    }
    setIsLoading(true);
    await fetch("/api/article/write", {
      method: "POST",
      body: JSON.stringify({
        title,
        content: JSON.stringify(convertToRaw(editorState.getCurrentContent())),
        hashtags : Array.from(new Set(hashtags)).filter((v, _, __)=>{return v!==""}),
        token: `Bearer ${localStorage.getItem("token")}`,
      }),
    }).then(res=>{
      if (res.ok){
        router.push("/article")
        alert("Sucess")
        return;
      }
      alert("Fail...")
    }).catch(err=>{
      alert("Fail...")
      console.log(err);
    }).finally(()=>{
      setIsLoading(false);
    })
  };

  return (
    <Container>
      {/* 헤더 */}
      <Grid p="sm" m="sm" justify="space-between">
        <Grid.Col span={7}>
          <Title order={3} weight={400} mb="lg">
            Write Article
          </Title>
        </Grid.Col>
        <Grid.Col span={3} offset={2}>
          <Group>
            <Button onClick={handleGoToArticlePage} disabled={isLoading} color="green">
              Back
            </Button>
            <Button onClick={handleSubmit} disabled={isLoading} color="yellow">
              Save
            </Button>
          </Group>
        </Grid.Col>
      </Grid>

      <Accordion
        multiple
        variant="separated"
        p="sm"
        m="sm"
        defaultValue={["title", "content"]}
      >
        {/* 제목 */}
        <ArticleTitleAccordian title={title} setTitle={setTitle} />

        {/* 본문 */}
        <ArticleContentAccrodian
          editorState={editorState}
          setEditorState={setEditorState}
        />

        {/* 해시태그 */}
        <ArticleHashtagAccordian
          hashtags={hashtags}
          setHashtags={setHashtags}
        />
      </Accordion>
    </Container>
  );
}
