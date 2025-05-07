import { Alarm } from "@/utils/model";
import {
  Avatar,
  Badge,
  Container,
  Grid,
  Group,
  Title,
  Tooltip,
} from "@mantine/core";
import { IconNotification } from "@tabler/icons-react";
import { useRouter } from "next/router";
import { useEffect, useState } from "react";

const navItmes = [
  {
    label: "Home",
    link: "/",
    showWhen: "ALL"
  },
  {
    label: "Article",
    link: "/article",
    showWhen: "ALL"
  },
  {
    label: "Write",
    link: "/article/write",
    showWhen: "LOGIN"
  },
  {
    label: "Alarm", 
    link: "/notification",
    showWhen: "LOGIN"
  },
  {
    label: "Register", 
    link: "/auth/sign-up",
    showWhen: "NOT_LOGIN"
  },
  {
    label: "Login", 
    link: "/auth/login",
    showWhen: "NOT_LOGIN"
  },
  {
    label: "Logout", 
    link: "/auth/logout",
    showWhen: "LOGIN"
  },
];

export default function MyNav() {
  const router = useRouter();
  const [username, setUsername] = useState<string | null>(null);
  const [isLogined, setIsLogined] = useState<boolean>(false);
  const [newAlarm, setNewAlarm] = useState<Alarm|null>(null);

  const handleClick = (link: string) => () => {
    router.push(link);
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    setIsLogined(false);
    router.push("/auth/login")
  }

  const handleDeleteNewAlarm = () => {
    setNewAlarm(null);
  }

  const getUsername = async () => {
    setIsLogined(false);
    const token = localStorage.getItem("token");
    try {
      if (!token) return;
      const data = await fetch("/api/user/get-username", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
        .then((res) => res.json())
        .then((json) => json.data)
        .catch((err) => console.error(err));
      setUsername(data);
      setIsLogined(true);
    } catch (err) {
      setIsLogined(false);
      console.error(err);
    }
  };

  const alarmSse = async () => {
    const token = await localStorage.getItem("token");
    if (!token) {
      return;
    }
    const endPoint = `http://localhost:8080/api/alarm/subscribe?token=${token}`;
  
    const eventSorce = new EventSource(endPoint);
  
    eventSorce.addEventListener("open", (e) => {
      console.log("sse open", e);
    });
    eventSorce.addEventListener('ALARM', (e) => {
      console.log("sse event occurs", e);
      setNewAlarm(JSON.parse(e.data));
    });
    eventSorce.addEventListener("error", (e) => {
      console.log("sse error", e);
      eventSorce.close();
    });
  };

  useEffect(() => {
    getUsername();
    alarmSse();
  }, [router.pathname]);
  

  return (
    <Container>
      <Grid justify="space-between" align="center" m="sm">
        <Grid.Col span={2}>
          <Title order={3}>Gallery</Title>
        </Grid.Col>

        <Grid.Col span={7}>
          <Group>
            {navItmes
              .filter((v, _, __) => {
                switch (v.showWhen) {
                  case "LOGIN":
                    return isLogined;
                  case "NOT_LOGIN":
                    return !isLogined;
                  default:
                    return true;
                }
              })
              .map((item, idx) => {
                const isSelected = item.link === router.pathname;
                const onClick = item.link === "/auth/logout" ? handleLogout : handleClick(item.link)
                return (
                  <Badge
                    key={idx}
                    size="lg"
                    color={isSelected ? "teal" : "gray"}
                    variant={isSelected ? "filled" : "outline"}
                    onClick={onClick}
                  >
                    {item.label}
                  </Badge>
                );
              })}
          </Group>
        </Grid.Col>

        <Grid.Col span={2} offset={1}>
          {isLogined && (
            <Group position="right">
              <Tooltip label={username}>
                <Avatar />
              </Tooltip>
              <Tooltip label={newAlarm?newAlarm.message:"No Alarm"}>
                <IconNotification color={newAlarm?"red":"gray"} onClick={handleDeleteNewAlarm}/>
              </Tooltip>
            </Group>
          )}
        </Grid.Col>
      </Grid>
    </Container>
  );
}
