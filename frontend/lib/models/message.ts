import BaseFields from "./base";

type MessageModel = {
    senderUid : string;
    receiverUid : string;
    content : string;
} & BaseFields

export default MessageModel