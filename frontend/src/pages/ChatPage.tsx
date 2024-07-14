import { useEffect, useRef, useState } from "react";
import SockJs from "sockjs-client";
import { Client, over } from "stompjs";

export default function ChatPage() {
  let stompClient = over(new SockJs("https://localhost:8080/ws"));
  const [isConnencted, setIsConnected] = useState<boolean>(false);
  const [messages, setMessages] = useState<any>([]);

  const handleSendMessage = () => {
    stompClient?.send("/app/message", {}, JSON.stringify({ content: "test" , jwt:"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5YjhmNTlmYi0zZDU5LTQ3YWUtOGRjYS1kZDkxNmQ2MzA2ZmE6VVNFUiIsImlzcyI6Imthcm1hIiwiaWF0IjoxNzIwOTA3MjE3LCJleHAiOjMwOTc2MzI5OTA2MX0.uv9yigQ3lpoy_ESBpdJh1IGDqLgyYQY6pQ7wYtGWxluFBi8HZ-lgxNTbD31O1McmrQW_qFym7atcLuFQSPxuFA"}));
  };

  useEffect(() => {
    stompClient.connect({}, () => {
      setIsConnected(true);
      stompClient?.subscribe("/chat/public");
    });
    return () => {
      if (isConnencted) {
        stompClient?.disconnect(() => {
          console.debug("disconnected");
        });
      }
    };
  }, []);

  return (
    <main>
      <h1>CHAT</h1>
      <button
        onClick={() => {
          handleSendMessage();
        }}
      >
        test
      </button>
    </main>
  );
}
