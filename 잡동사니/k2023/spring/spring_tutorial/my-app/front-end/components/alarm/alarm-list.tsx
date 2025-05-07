import { Alarm } from "@/utils/model";
import { Box, Notification } from "@mantine/core";
import { IconCheck } from "@tabler/icons-react";
import AlarmText from "./alarm-text";

export default function AlarmList(props: {
  alarms: Alarm[];
  getAlarms: Function;
}) {
  const handleDelete = (alarmId: number) => async () => {
    const token = await localStorage.getItem("token");
    if (!token) return;
    try {
      fetch(`/api/alarm/delete?id=${alarmId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }).then((res) => {
        props.getAlarms();
      });
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <Box>
      {props.alarms.map((alarm, idx) => {
        return (
          <Notification
            icon={<IconCheck size="1.1rem" />}
            title={alarm.message}
            key={idx}
            color="cyan"
            p="sm"
            m="sm"
            onClose={handleDelete(alarm.id)}
          >
            <Box p="sm"><AlarmText alarmType={alarm.alarmType} memo={alarm.memo} /></Box>
          </Notification>
        );
      })}
    </Box>
  );
}
