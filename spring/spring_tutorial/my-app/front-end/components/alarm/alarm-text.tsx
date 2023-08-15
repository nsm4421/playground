import { parseLocalDateTimeInKoreanTime } from "@/utils/date-util";
import { AlarmMemo, AlarmType } from "@/utils/model";
import { Badge, Grid, Group, Text } from "@mantine/core";
import Link from "next/link";

import { useEffect, useState } from "react";

export default function AlarmText(props: {
  memo: string;
  alarmType: AlarmType;
}) {
  const [json, setJson] = useState<AlarmMemo | null>(null);

  const paddingForMessage = (
    str: string,
    maxLength: number = 100,
    numRepeat: number = 3,
    paddingText: string = "."
  ) => {
    if (str.length < maxLength - numRepeat) {
      return str;
    } else {
      return str + paddingText.repeat(numRepeat);
    }
  };

  useEffect(() => {
    try {
      setJson(JSON.parse(props.memo));
    } catch (e) {
      console.error(e);
      return;
    }
  }, [props]);

  if (props.alarmType === "NEW_COMMENT_ON_ARTICLE") {
    return (
      <Grid>
        <Grid.Col span={9}>
          <Group>
            <Badge>Title</Badge>
            <Text>
              <Link href={`/article/${json?.articleId}`}>{json?.title}</Link>
            </Text>
          </Group>
          <Group mt="sm">
            <Badge>Comment</Badge>
            {json?.comment && paddingForMessage(json?.comment)}
          </Group>
        </Grid.Col>
        <Grid.Col span={2} offset={1}>
          {json?.createdAt && parseLocalDateTimeInKoreanTime(json.createdAt)}{" "}
        </Grid.Col>
      </Grid>
    );
  }

  if (props.alarmType === "NEW_EMOTION_ON_ARTICLE") {
    return (
      <Grid>
        <Grid.Col span={9}>
          <Group>
            <Badge>Title</Badge>
            <Text>
              <Link href={`/article/${json?.articleId}`}>{json?.title}</Link>
            </Text>
          </Group>
          <Group mt="sm">
            <Badge>Emotion</Badge>
            {json?.emotion}
          </Group>
        </Grid.Col>
        <Grid.Col span={2} offset={1}>
          {json?.createdAt && parseLocalDateTimeInKoreanTime(json.createdAt)}{" "}
        </Grid.Col>
      </Grid>
    );
  }
  return (
    <Group>
      <Badge>Title</Badge>
      <Text>
        {" "}
        <Link href={`/article/${json?.articleId}`}>{json?.title}</Link>
      </Text>
    </Group>
  );
}
