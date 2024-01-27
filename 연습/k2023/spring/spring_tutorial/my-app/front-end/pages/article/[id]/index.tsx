import ArticleContent from "@/components/article/detail/article-content";
import { useRouter } from "next/router";
import { useEffect, useState } from "react";
import { Article } from "@/utils/model";
import ArticleComment from "@/components/article/detail/article-comment";
import ErrorPage from "@/components/error";
import { Container } from "@mantine/core";
export default function ArticleDetail() {
  const router = useRouter();
  const { id } = router.query;
  const [article, setArticle] = useState<Article | null>(null);

  const getArticle = async () => {
    if (!id) {
      return;
    }
    const data = await fetch(`/api/article/get-article?id=${id}`)
      .then((res) => res.json())
      .then((json) => json.data.data);
    setArticle(data);
  };

  useEffect(() => {
    getArticle();
  }, [id]);

  if (id === undefined || !(typeof(id) === "string")){
    return <ErrorPage/>
   }

  return (
    <Container>
      <ArticleContent id={id} article={article} />
      <ArticleComment id={id}/>
    </Container>
  );
}
