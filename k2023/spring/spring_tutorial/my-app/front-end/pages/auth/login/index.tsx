import { TextInput, Button, Group, Box, Divider } from "@mantine/core";
import { useRouter } from "next/router";
import { Alert } from "@mantine/core";
import { IconAlertCircle } from "@tabler/icons-react";
import { useState } from "react";

export default function Login() {
  const router = useRouter();
  const [username, setUsername] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const handleUsername = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUsername(e.target.value);
  };
  const handlePassword = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPassword(e.target.value);
  };
  const handleGoToArticlePage = () => {
    router.push("/article");
  };

  const clearErrorMessage = () => {
    setErrorMessage(null);
  };

  // 회원가입 요청
  const handleSubmit = async () => {
    setIsLoading(true);
    await fetch("/api/user/login", {
      method: "POST",
      body: JSON.stringify({ username, password }),
    })
      .then((res) => res.json())
      .then((res) => {
        // 로그인 성공시 → 토큰을 저장
        if (res.data) {
          console.debug(res.message);
          localStorage.setItem("token", res.data.token);
          handleGoToArticlePage();
          return;
        }
        // 로그인 실패시 → 에러 메세지 보여주기
        setErrorMessage(res.message ?? "Error Occurs...");
        setIsLoading(false);
      })
      .catch((err) => {
        setErrorMessage(err.data);
        setIsLoading(false);
      });
  };

  return (
    <Box maw={500} mx="auto">
      <h1>Login</h1>
      <Divider mt={"sm"} m={"lg"} />
      <Alert
        icon={<IconAlertCircle size="1rem" />}
        title="Login Fail"
        color="red"
        radius="md"
        hidden={errorMessage === null}
        onClick={clearErrorMessage}
      >
        {errorMessage}
      </Alert>

      <TextInput
        withAsterisk
        label={"Username"}
        placeholder={"press username"}
        value={username}
        onChange={handleUsername}
        mb={"sm"}
      />
      <TextInput
        type="password"
        withAsterisk
        label={"Password"}
        placeholder={"press password"}
        value={password}
        onChange={handlePassword}
        mb={"sm"}
      />

      {/* Login Button */}
      <Group position="right" mt="md">
        <Button
          type="submit"
          onClick={handleSubmit}
          disabled={isLoading}
          color="green"
        >
          Submit
        </Button>
      </Group>
    </Box>
  );
}
