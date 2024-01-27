import ArticleCard from "@/components/article/list/article-card";
import axios from "axios";
import { Badge, Box, Grid, Text } from "@mantine/core";
import { useEffect, useState } from "react";
import { Article } from "@/utils/model";
import SearchArticle from "./search-article";
import PagingBar from "./pagination-bar";
import Loading from "@/components/loading";

export default function ArticleList() {
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [totalPages, setTotalpages] = useState<number>(1);
  const [endPoint, setEndPoint] = useState<string | null>(null);
  const [articles, setArticles] = useState<Article[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const getArticles = async () => {
    setIsLoading(true);
    await axios
      .get(endPoint ?? "http://localhost:8080/api/article")
      .then((res) => res.data.data)
      .then((data) => {
        setArticles([...data.content]);
        setTotalpages(data.totalPages);
      })
      .catch((err) => {
        console.error(err);
      });
    setIsLoading(false);
  };

  useEffect(() => {
    getArticles();
    return;
  }, [pageNumber]);

  if (isLoading){
    return <Loading/>
  }

  return (
    <>
      {/* 헤더 */}
      <Box m="sm" p="lg">
        <Grid grow align="center" justify="space-between">
          <Grid.Col span={2}>
            <Badge p="sm" m="sm">
              Page
            </Badge>
          </Grid.Col>
          <Grid.Col span={10}>
            {/* 페이징 바 */}
            <PagingBar
              pageNumber={pageNumber}
              setPageNumber={setPageNumber}
              totalPages={totalPages}
            />
          </Grid.Col>
        </Grid>
      </Box>

      {/* 검색 옵션 아코디언 */}
      <Box m="sm" p="sm">
        <SearchArticle
          pageNumber={pageNumber}
          setPageNumber={setPageNumber}
          setEndPoint={setEndPoint}
          getArticles={getArticles}
          setIsLoading={setIsLoading}
        />
      </Box>

      {/* 게시글 List */}
      {articles.map((article, idx) => (
        <Box key={idx} m="sm" p="sm">
          <ArticleCard article={article} />
        </Box>
      ))}
    </>
  );
}
