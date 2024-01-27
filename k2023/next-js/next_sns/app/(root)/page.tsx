import { UserButton } from "@clerk/nextjs/app-beta";

export default function Home() {
  return (
    <main>
      <h1>Home</h1>  
      <UserButton afterSignOutUrl="/"/>    
    </main>
  )
}
