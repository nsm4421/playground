import express from "express";
import { json } from "body-parser";
import authRouter from "./routes/auth.route";

const app = express();

app.use(json());
app.use("/api/auth", authRouter);

const PORT = process.env.PORT || 6000;
app.listen(PORT, () => {
  console.debug(`app started on ${PORT} port`);
});
