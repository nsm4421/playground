import './utils.css'

const Button = ({label, onClick})=>{
    return (
        <button className='custom__button' onClick={onClick}>{label}</button>
    )
}

export default Button;