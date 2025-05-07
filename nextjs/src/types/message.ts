export default interface Message {
  id: number;
  senderId: string;
  content: string;
  messageType: "text" | "image";
}
