import ChatRoomList from "./chatRoomList";
import Room from "./Room";

const test_lst = [
    {
        title:"채팅1",
        number:5,
        host:"카르마"
    },
    {
        title:"채팅2",
        number:2,
        host:"질리언"
    },
    {
        title:"채팅3",
        number:5,
        host:"딩거"
    }
]

const test_chat={
    chatRoomId:1,
    title:"채팅1",
    host:"카르마",
    messages:[
        {message:"hi", createdBy:"카르마", createdAt:"작성시간1"},
        {message:"hi", createdBy:"질리언", createdAt:"작성시간2"},
        {message:"hi", createdBy:"딩거", createdAt:"작성시간3"},
        {message:"hi", createdBy:"카르마", createdAt:"작성시간4"},
    ]
}

const ChatRoom = () => {
    return (
        <div>
            <aside>
                <ChatRoomList lst={test_lst}/>
            </aside>
            <main>
                <Room chats={test_chat}/>
            </main>
        </div>
    )
}

export default ChatRoom;