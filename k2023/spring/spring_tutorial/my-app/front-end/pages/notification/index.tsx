import AlarmList from "@/components/alarm/alarm-list";
import PagingBar from "@/components/article/list/pagination-bar";
import { Alarm } from "@/utils/model";
import {  Button, Container, Grid, Group, Title, Tooltip } from "@mantine/core";
import { IconLoader, IconRefresh, IconTrash } from "@tabler/icons-react";
import { useEffect, useState } from "react";

export default function Alarm() {
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [totalElements, setTotalElements] = useState<number>(0);
  const [totalPages, setTotalPages] = useState<number>(1);
  const [alarms, setAlarms] = useState<Alarm[]>([]);

  const getAlarms = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      alert("Need to login");
      return;
    }
    try {
      const data = await fetch(`/api/alarm/get?page=${pageNumber-1}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
        .then((res) => res.json())
        .then((json) => json.data)
        .catch((err) => console.error(err));
      setAlarms(data.content);
      setTotalPages(data.totalPages);
      setTotalElements(data.totalElements)
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  const deleteAll = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      alert("Need to login");
      return;
    }
    try {
      await fetch("/api/alarm/delete-all", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }).catch((err) => console.error(err));
      setAlarms([]);
      setTotalElements(0);
    } catch (err) {
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    getAlarms();
  }, [pageNumber, isLoading]);

  return (
    <Container>
      <Grid p="sm" m="sm" justify="space-between">
        <Grid.Col span={5}>
          <Group>
            <Title order={4}>Alarm</Title>
            <Title order={6}>({totalElements})</Title>

            {/* 새로고침 버튼 */}
            <Tooltip label={"Refresh"}>
              <Button variant="subtle" onClick={getAlarms} disabled={isLoading}>
              {
                  isLoading?<IconLoader/>:<IconRefresh/>
                } 
              </Button>
            </Tooltip>

            {/* 모두 지우기 버튼 */}
            <Tooltip label={"Delete All"}>
              <Button variant="subtle" onClick={deleteAll} disabled={isLoading}>
                {
                  isLoading?<IconLoader/>:<IconTrash/>
                }                
              </Button>
            </Tooltip>
          </Group>
        </Grid.Col>
        <Grid.Col span={5}>
        <PagingBar pageNumber={pageNumber} setPageNumber={setPageNumber} totalPages={totalPages}/>
       </Grid.Col>
      </Grid>

      {/* 알람 리스트 */}
      <AlarmList alarms={alarms} getAlarms={getAlarms}/>
      </Container>
  );
}
