import Message from "@/types/message";
import dummyUsers from "./user";

const dummyMessages: Message[] = [
  {
    id: 1,
    senderId: dummyUsers[0].id,
    content: "Hello",
    messageType: "text",
  },
  {
    id: 2,
    senderId: dummyUsers[1].id,
    content: "Hi",
    messageType: "text",
  },
  {
    id: 3,
    senderId: dummyUsers[0].id,
    content: "How are you?",
    messageType: "text",
  },
  {
    id: 4,
    senderId: dummyUsers[1].id,
    content: "I'm good",
    messageType: "text",
  },
  {
    id: 5,
    senderId: dummyUsers[0].id,
    content: "What are you doing?",
    messageType: "text",
  },
  {
    id: 6,
    senderId: dummyUsers[1].id,
    content: "Nothing much",
    messageType: "text",
  },
  {
    id: 7,
    senderId: dummyUsers[0].id,
    content: "Cool",
    messageType: "text",
  },
  {
    id: 8,
    senderId: dummyUsers[1].id,
    content: "Yeah",
    messageType: "text",
  },
  {
    id: 9,
    senderId: dummyUsers[0].id,
    content: "Bye",
    messageType: "text",
  },
  {
    id: 10,
    senderId: dummyUsers[1].id,
    content: "Bye",
    messageType: "text",
  },
];

export default dummyMessages;
