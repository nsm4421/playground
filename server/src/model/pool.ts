import { Pool } from "pg";

// TODO : 접속정보 .env파일로 관리하기
const pool = new Pool({
  user: "karma",
  password: "1221",
  host: "localhost",
  port: 5432,
  database: "dev_db",
});

export default pool;
