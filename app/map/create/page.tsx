import AddPlanForm from "@/components/map/add-plan-form";
import InitLocation from "@/lib/store/map/init-location";

export default function Page() {
  return (
    <main>
      <div className="mt-5 mb-3 p-2">
        <h1 className="text-2xl">Add Travel Plan</h1>
        <span className="text-medium text-slate-700">Share your internary</span>
      </div>
      <AddPlanForm />
      <InitLocation />
    </main>
  );
}
