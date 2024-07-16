import SignUpForm from "./_form";

export default function SignUpAction(){
    return <main>
        <h1 className="text-lg">Sign Up</h1>

        <section className="mx-3 my-5 p-3">
            <SignUpForm/>
        </section>
    </main>
}