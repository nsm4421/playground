const myStyle={
    dropdownLabel : {
        color:"red"
    },
    
    dropbtn : {
        display : "block",
        border : "2px solid rgb(94, 94, 94)",
        borderRadius : "4px",
        backgroundColor: "#fcfcfc",
        position : "relative"
      }
}

export default function MyDropDownButton(props){
    return (
        <>
            <div className="dropdownLabel" style={myStyle.dropdownLabel}>
                {props.title}  
            </div>
            <div className="dropdown">

                <button className="dropbtn" style={myStyle.dropbtn}>
                    <span>Choose</span>
                    {/* <span className="dropbtn_click" style="font-family: Material Icons; font-size : 16px; color : #3b3b3b; float:right;"
                        onclick="dropdown()">arrow_drop_down</span> */}
                </button>

                <div className="dropdown-content" onClick={()=>{}}>
                    {
                        props.items.map((item, idx)=>{
                            return(
                                <div key={idx}>
                                    {item}
                                </div>
                            )
                        })     
                      
                    }
                </div>
            </div>
        </>
    )
}