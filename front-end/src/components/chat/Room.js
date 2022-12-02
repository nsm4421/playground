const Room = ({chats})=>{
    return (
    <>
        <h2>{chats.title}</h2>
        <h2>Host <span>{chats.host}</span></h2>
        <ul>
            {
                chats.messages.map((c, i)=>{
                    return(
                        <li key={i}>
                            <p>
                                <span>호스트 : {c.createdBy}</span>
                                <span>{c.createdAt}</span>
                            </p>
                            <p>{c.message}</p>
                            <button><a href={`/${chats.chatRoomId}`}>입장</a></button>
                        </li>
                    )
                })
            }
        </ul>
    </>
    );
};
export default Room;