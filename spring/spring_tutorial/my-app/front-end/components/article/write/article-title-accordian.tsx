import { Accordion, Badge, TextInput } from "@mantine/core";
import { Dispatch, SetStateAction } from "react";

export default function ArticleTitleAccordian({title, setTitle}:{
    title:string, setTitle:Dispatch<SetStateAction<string>>
}){
    const handleTitle = (e: React.ChangeEvent<HTMLInputElement>) => {
        setTitle(e.target.value);
      };
      
    return <Accordion.Item value="title">
      <Accordion.Control>
        <Badge pt="sm" pb="sm" mb="sm">
          Title
        </Badge>
      </Accordion.Control>
      <Accordion.Panel>
        <TextInput
          value={title}
          onChange={handleTitle}
          placeholder="character of title is less than 100"
          withAsterisk
        />
      </Accordion.Panel>
    </Accordion.Item>
}