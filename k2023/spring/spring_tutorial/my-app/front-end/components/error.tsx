export default function ErrorPage(props:{errorMessage?:string}){
    return <>
    <h1>{props.errorMessage?"EROOR":props.errorMessage}</h1>
    </>
}