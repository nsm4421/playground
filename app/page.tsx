import { Button } from "@/components/ui/button";

export default function Page() {
  return (
    <main className="max-w-3xl mx-auto md:py-5 h-screen">
      <div className="h-full border rounded-md">
        <section className="px-5 py-3">
          <div>
            <div className="flex justify-between items-center">
              <div>
                <p>NICKNAME</p>
                <div className="flex">
                  <p className="h-5 w-5 bg-green-500 rounded-full animate-pulse"></p>
                  <p className="ml-2 text-sm text-slate-500">STATUS</p>
                </div>
              </div>
              <div>
                <Button>LOGIN</Button>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
  );
}
