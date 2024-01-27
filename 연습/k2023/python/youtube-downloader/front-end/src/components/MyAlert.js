export default function MyAlert({variant, show, setShow, message, setMessage}){
    const handleClickAlert = (e) => {
        setShow(false);
        setMessage("");
    }
    if (show){
        return (
            <div className={"alert alert-"+(variant??"danger")} role="alert" onClick={handleClickAlert}>
                {message}
             </div>
        )
    }
}
