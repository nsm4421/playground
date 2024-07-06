import AccountModel from "./account";
import BaseFields from "./base";
import MessageModel from "./message";

type ConversationModel = {
  participants: AccountModel[];
  messages: MessageModel[];
} & BaseFields;

export default ConversationModel;
