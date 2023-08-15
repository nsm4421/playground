import { Emotion, EmtoionCountMap } from "@/utils/model";
import { ActionIcon, Group, Text } from "@mantine/core";
import { IconThumbDown, IconThumbUp } from "@tabler/icons-react";
import axios from "axios";
import { useEffect, useState } from "react";

export default function EmotionButton(props: { id: string }) {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [emotionCountMap, setEmotionCountMap] = useState<EmtoionCountMap>(null);
  const [currentEmotion, setCurrentEmotion] = useState<Emotion>(null);

  // 감정표현 가져오기
  useEffect(() => {
    // 감정표현 개수 가져오기
    getEmotionCountMap();
    getMyEmotion();
  }, [currentEmotion]);

  const getEmotionCountMap = async () => {
    setIsLoading(true);
    await axios
      .get(`http://localhost:8080/api/emotion?article-id=${props.id}`)
      .then((res) => res.data)
      .then((data) => {
        setEmotionCountMap({
          LIKE: data.data.LIKE,
          DISLIKE: data.data.DISLIKE,
        });
      })
      .catch((err) => {
        console.log(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  const getMyEmotion = async () => {
    const token = await localStorage.getItem("token");
    setIsLoading(true);
    await axios
      .get(`http://localhost:8080/api/emotion/${props.id}`, {
        headers: {
          Authorization: `Bearer ${token}`
        },
      })
      .then((res) => res.data)
      .then((data) => {
        setCurrentEmotion(data.data??null)
      })
      .catch((err) => {
        console.log("getMyEmotion >>> ",err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  const handleEmotion = (emotion: Emotion) => async () => {
    const token = await localStorage.getItem("token");
    if (!token) {
      alert("Need to login");
      return;
    }
    setIsLoading(true);
    await axios
      .post(
        "http://localhost:8080/api/emotion",
        {
          articleId: props.id,
          emotion,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`
          }
        }
      )
      .then((res) => {
        getMyEmotion();
      })
      .catch((err) => {
        alert("Error occurs");
        console.error(err);
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <>
      {/* 좋아요 아이콘 */}
      <Group position="right" mt="sm">
        <Group mr="sm" >
          <ActionIcon disabled={isLoading} onClick={handleEmotion("LIKE")}>
            <IconThumbUp color={currentEmotion == "LIKE" ? "red" : undefined} />
          </ActionIcon>

          {emotionCountMap && (
            <Text>{emotionCountMap.LIKE}</Text>
          )}
        </Group>

        {/* 싫어요 아이콘 */}
        <Group>
          <ActionIcon disabled={isLoading} onClick={handleEmotion("DISLIKE")}>
            <IconThumbDown
              color={currentEmotion == "DISLIKE" ? "blue" : undefined}
            />
          </ActionIcon>
          {emotionCountMap && (
            <Text>{emotionCountMap.DISLIKE}</Text>
          )}
        </Group>
      </Group>
    </>
  );
}