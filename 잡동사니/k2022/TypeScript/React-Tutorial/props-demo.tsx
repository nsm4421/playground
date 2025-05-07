type GreetProps = {
    name:string,            
    sex:'male'|'female',       
    age:number,
    hobby:string[]
}

export const Greet = (props:GreetProps) => {
    return (
        <div>
            <h2>Pass Pros</h2>
            
            <h3>Hi ~ I'm {props.name}</h3>
            
            <h3>I am {props.sex} and {props.age}'s old</h3>

            <h3>My hobby</h3>
            <ul>
                {
                    props.hobby.map((h, i)=>{
                        return (
                            <li key={i}>{i+1}. {h}</li>
                        )
                    })
                }
            </ul>
        </div>
    )
}