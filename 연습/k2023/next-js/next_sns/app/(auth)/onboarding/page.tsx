import OnBoardingForm from "@/components/form/onboarding-form";
import { currentUser } from "@clerk/nextjs";

export default async function Page() {
  const user = await currentUser().then((u) => ({
    id: u?.id??'',
    objectId: u?.id??'',
    username: u?.username??'',
    name: u?.firstName??'',
    bio: u?.birthday??'',
    image: u?.imageUrl??'',
  }));

  return (
    <main className="mx-auto max-w-3xl mt-10">
      <h1 className="text-2xl font-extrabold">On Boading</h1>
      <p className="mt-5 mb-10">Complete your profile</p>
      <section className="bg-slate-700 rounded-2xl shadow-lg shadow-slate-600">
        <OnBoardingForm user={user} btnTitle="test" />
      </section>
    </main>
  );
}
