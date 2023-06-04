import { connectDB as client } from "@/util/database";


export default async function Home() {
  const db = (await client).db(process.env.DB_NAME);
  const data = await db.collection("post").find().toArray();
  return (
    <>
      <h1>Home</h1>
      {
        data.map((r, i)=>(<div key={i}>
          <h3>{r.title}</h3>
          <h3>{r.content}</h3>
        </div>))
      }
    </>
  );
}
