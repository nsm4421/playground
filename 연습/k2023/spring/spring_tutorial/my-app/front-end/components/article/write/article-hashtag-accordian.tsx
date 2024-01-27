import { Accordion, Badge, Button, Group, TextInput } from "@mantine/core";
import { IconHash, IconPlus, IconTrash } from "@tabler/icons-react";
import { Dispatch, SetStateAction } from "react";

export default function ArticleHashtagAccordian({
  hashtags,
  setHashtags,
}: {
  hashtags: string[];
  setHashtags: Dispatch<SetStateAction<string[]>>;
}) {
  const MAX_HASHTAG_NUM = 5;
  const handleHashtag =
    (idx: number) => (e: React.ChangeEvent<HTMLInputElement>) => {
      const newHashtag = [...hashtags];
      newHashtag[idx] = e.target.value;
      setHashtags(newHashtag);
    };
  const addHashtag = () => {
    if (hashtags.length <= MAX_HASHTAG_NUM) {
      setHashtags([...hashtags, ""]);
    }
  };
  const deleteHashtag = (idx: number) => () => {
    if (hashtags.length > 1) {
      const newHashtag = [...hashtags];
      newHashtag.splice(idx, 1);
      setHashtags(newHashtag);
    }
  }; 

  return (
    <Accordion.Item value="hashtag">
      <Accordion.Control>
        <Badge pt="sm" pb="sm" mt="sm">
          Hashtag
        </Badge>
      </Accordion.Control>
      <Accordion.Panel>
        <Group p="sm">
          {hashtags.length < MAX_HASHTAG_NUM && (
            <Button
              onClick={addHashtag}
              variant="subtle"
              radius="xl"
              size="md"
              uppercase
              disabled={hashtags.length >= MAX_HASHTAG_NUM}
            >
              <IconPlus size={"1rem"} />
            </Button>
          )}
          {hashtags.map((hashtag, idx) => (
            <TextInput
              value={hashtag}
              onChange={handleHashtag(idx)}
              placeholder={`hashtag${idx + 1}`}
              icon={<IconHash />}
              rightSection={
                <IconTrash
                  color="red"
                  size={"1rem"}
                  onClick={deleteHashtag(idx)}
                />
              }
              key={idx}
              maw={200}
            />
          ))}
        </Group>
      </Accordion.Panel>
    </Accordion.Item>
  );
}
