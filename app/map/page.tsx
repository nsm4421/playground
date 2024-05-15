import AddPlanForm from "@/components/add-plan-form";
import InitLocation from "@/lib/store/map/init_location";

export default function Page() {
  return (
    <main>
      <AddPlanForm/>
      <InitLocation />
    </main>
  );
}
