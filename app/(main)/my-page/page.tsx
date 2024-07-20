import SelectImageForm from "./_form";

export default function MyPage() {
  return (
      <main className="container">
        <div className="my-10">
          <h1 className="text-2xl font-extrabold">My Page</h1>
        </div>
        <section className="mx-auto">
          <SelectImageForm />
        </section>
      </main>
  );
}
