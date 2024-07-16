import AuthForm from "./login/_form";

export default function AuthPage(){
    return <main>
        <h1 className="text-lg">Authentication</h1>

        <section>
            <AuthForm/>
        </section>
    </main>
}