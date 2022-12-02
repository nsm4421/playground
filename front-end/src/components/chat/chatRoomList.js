

const ChatRoomList = ({lst}) => {
    return (
        <div>
            {
                lst.map((l, i)=>{
                    return (
                    <ul key={i}>
                        <li>{l.title}</li>
                        <li>{l.number}</li>
                        <li>{l.host}</li>
                    </ul>
                    );
                })
            }

        </div>
    );
}

export default ChatRoomList;