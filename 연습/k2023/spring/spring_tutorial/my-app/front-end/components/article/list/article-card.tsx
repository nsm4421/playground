import { parseLocalDateTimeInKoreanTime } from "@/utils/date-util";
import { Article } from "@/utils/model";
import { Card, Image, Text, Badge, Group, Box, Button } from "@mantine/core";
import { useRouter } from "next/router";
import { FaHashtag } from "react-icons/fa";
import { WiDirectionRight } from "react-icons/wi";

export default function ArticleCard({ article }: { article: Article }) {
  const router = useRouter();

  const handleClickGoButton = (id: Number) => () => {
    router.push(`/article/${id}`);
  };

  return (
    <Card shadow="sm" padding="lg" radius="md" withBorder>
      {/* 썸네일 */}
      <Card.Section>
        {/* TODO : 이미지 변경 */}
        <Image
          src="https://images.unsplash.com/photo-1527004013197-933c4bb611b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=720&q=80"
          height={160}
          alt="Norway"
        />
      </Card.Section>

      <Group position="apart" mt="md" mb="xs">
        {/* 제목 */}
        <Text weight={500}>{article.title}</Text>
      </Group>

      <Group position="apart" mt="md" mb="xs" pl="sm" pr="sm">
        {/* 유저명 */}
        <Text size="sm" color="dimmed">
          {article.createdBy}
        </Text>

        {/* 상세 페이지로 버튼 */}
        <Button
          color="pink"
          variant="light"
          onClick={handleClickGoButton(article.id)}
        >
          <Text>Go</Text>
          <WiDirectionRight style={{ fontSize: "20px" }} />
        </Button>
      </Group>

      <Group position="apart" mt="md" mb="xs">
        {/* 해시태그 */}
        <Box maw={400}>
          <Badge>
            <FaHashtag />
          </Badge>
          {Array.from(article.hashtags).map((hashtag, idx) => (
            <Badge key={idx}>{hashtag}</Badge>
          ))}
        </Box>

        {/* 작성시간 */}
        <Text size="sm" color="dimmed">
          {article.createdAt &&
            parseLocalDateTimeInKoreanTime(article.createdAt)}
        </Text>
      </Group>
    </Card>
  );
}
