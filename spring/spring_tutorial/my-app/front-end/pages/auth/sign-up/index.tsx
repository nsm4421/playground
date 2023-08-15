import { TextInput, Button, Group, Box, Divider } from "@mantine/core";
import { useRouter } from "next/router";
import { Alert } from "@mantine/core";
import { IconAlertCircle } from "@tabler/icons-react";
import { useState } from "react";

export default function SignUp() {
  const router = useRouter();
  const [username, setUsername] = useState<string | null>(null);
  const [password, setPassword] = useState<string | null>(null);
  const [email, setEmail] = useState<string | null>(null);
  const [passwordConfirm, setPasswordConfirm] = useState<string | null>(null);
  const [usernameErrorMessage, setUsernameErrorMessage] = useState<
    string | null
  >(null);
  const [passwordErrorMessage, setPasswordErrorMessage] = useState<
    string | null
  >(null);
  const [emailErrorMessage, setEmailErrorMessage] = useState<string | null>(
    null
  );
  const [passwordConfirmErrorMessage, setPasswordConfirmErrorMessage] =
    useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleUsername = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUsername(e.target.value);
    // 3~30자
    if (username && !username.match(/[a-zA-Z0-9-]{3,30}/)) {
      setUsernameErrorMessage("username length is between 5~30");
      return;
    }
    setUsernameErrorMessage(null);
  };
  const handlePassword = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPassword(e.target.value);
    // 5~30자
    if (password && !password.match(/[a-zA-Z0-9-]{5,30}/)) {
      setPasswordErrorMessage("password length is between 5~30");
      return;
    }
    setPasswordErrorMessage(null);
  };
  const handlePasswordConfirm = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPasswordConfirm(e.target.value);
    if (!(password == e.target.value)) {
      setPasswordConfirmErrorMessage(
        "Password and its confirm are not matched"
      );
      return;
    }
    setPasswordConfirmErrorMessage(null);
  };
  const handleEmail = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmail(e.target.value);
    if (
      email &&
      !email.match(
        /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      )
    ) {
      setEmailErrorMessage("Email is not valid");
      return;
    }
    setEmailErrorMessage(null);
  };

  const clearErrorMessage = () => {
    setErrorMessage(null);
  };
  const goToLoginPage = () => {
    router.push("/auth/login");
  };

  const checkInputs = (): boolean => {
    if (!username) {
      setErrorMessage("Username is blank");
      return false;
    }
    if (!email) {
      setErrorMessage("Email is blank");
      return false;
    }
    if (!password) {
      setErrorMessage("Password is blank");
      return false;
    }
    if (!passwordConfirm) {
      setErrorMessage("Password is blank");
      return false;
    }
    if (usernameErrorMessage) {
      setErrorMessage(usernameErrorMessage);
      return false;
    }
    if (emailErrorMessage) {
      setErrorMessage(emailErrorMessage);
      return false;
    }
    if (passwordErrorMessage) {
      setErrorMessage(passwordConfirm);
      return false;
    }
    if (passwordConfirmErrorMessage) {
      setErrorMessage(passwordConfirmErrorMessage);
      return false;
    }
    return true;
  };

  // 회원가입 요청
  const handleSubmit = async () => {
    setIsLoading(true);
    // 입력값 체크
    if (!(await checkInputs())) {
      setIsLoading(false);
      return;
    }
    try {
      await fetch("/api/user/sign-up", {
        method: "POST",
        body: JSON.stringify({ username, password, email }),
      })
        // 회원가입 성공시 → 로그인 페이지로
        .then((res) => {
          if (res.ok) {
            goToLoginPage();
            return;
          }
          return res;
        })
        .then((res) => res?.json())
        // 회원가입 실패시 → 에러 메세지 보여주기
        .then((data) => {
          setErrorMessage(data.message ?? "Error Occurs...");
        })
        .catch((err) => {
          setErrorMessage(err.data);
        });
    } catch (e) {
      console.error("Error on sign up >>> ", e);
      setIsLoading(false);
    }
  };

  return (
    <Box maw={500} mx="auto">
      <h1>Sign Up Page</h1>
      <Divider mt={"sm"} m={"lg"} />

      {/* 에러메세지 */}
      <Alert
        icon={<IconAlertCircle size="1rem" />}
        title="Sign Up Fail"
        color="red"
        radius="md"
        hidden={!errorMessage}
        onClick={clearErrorMessage}
      >
        {errorMessage}
      </Alert>

      {/* 유저명 */}
      <TextInput
        mt={"sm"}
        withAsterisk
        label={"Username"}
        placeholder={"username for login (3~30 character)"}
        value={username ?? ""}
        onChange={handleUsername}
        error={usernameErrorMessage}
      />

      {/* 이메일 */}
      <TextInput
        mt={"sm"}
        withAsterisk
        label={"Email"}
        placeholder={"Email address"}
        value={email ?? ""}
        onChange={handleEmail}
        error={emailErrorMessage}
      />

      {/* 비밀번호 */}
      <TextInput
        mt={"sm"}
        type="password"
        withAsterisk
        label={"Password"}
        placeholder={"password for login (5~30 character)"}
        value={password ?? ""}
        onChange={handlePassword}
        error={passwordErrorMessage}
      />

      {/* 비밀번호 확인 */}
      <TextInput
        mt={"sm"}
        type="password"
        withAsterisk
        label={"Password Confirm"}
        placeholder={"password again"}
        value={passwordConfirm ?? ""}
        onChange={handlePasswordConfirm}
        error={passwordConfirmErrorMessage}
      />

      {/* 회원가입 버튼 */}
      <Group position="right" mt="md">
        <Button
          type="submit"
          onClick={handleSubmit}
          disabled={isLoading}
          color="red"
        >
          Submit
        </Button>
      </Group>
    </Box>
  );
}
