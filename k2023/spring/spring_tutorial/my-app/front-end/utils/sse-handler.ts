const sse = ({
  openCallback,
  alarmCallback,
  errorCallback,
}: {
  openCallback: Function;
  alarmCallback: Function;
  errorCallback: Function;
}) => {
  const token = localStorage.getItem("token");
  if (!token) {
    alert("Need to login");
    return;
  }
  const endPoint = `http://localhost:8080/api/alarm/subscribe?token=${token}`;
  const eventSorce = new EventSource(endPoint);
  eventSorce.addEventListener("open", (e) => {
    console.log("connection opened...");
    openCallback();
  });
  eventSorce.addEventListener("ALARM", (e) => {
    console.log("alarm event occured ..." + e);
    const data = JSON.parse(e.data);
    alarmCallback(data);
  });
  eventSorce.addEventListener("error", (e) => {
    console.log(e);
    errorCallback();
    eventSorce.close();
  });
};
export default sse;
