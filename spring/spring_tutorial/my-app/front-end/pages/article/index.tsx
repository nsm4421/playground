import { Article } from "@/utils/model";
import ArticleList from "@/components/article/list/articles-list";
import { Box, Container } from "@mantine/core";

export default function Article() {

  return (
    <Container>
      <Box mt="lg">
      <ArticleList />
      </Box>
    </Container>
  );
}
