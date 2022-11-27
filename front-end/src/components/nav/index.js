const Navbar = () => {

    const navList = [
        {label:"홈", href:"/"},
        {label:"회원가입", href:"/register"},
        {label:"로그인", href:"/login"},
        {label:"로그아웃", href:"/logout"},
        {label:"채팅방", href:"/chats"},
    ]

    return (
        <nav>
            <h1>Navbar</h1>
            <ul>
                {
                    navList.map((n, i)=>{
                        return (
                            <li key={i}><a href={n.href}>{n.label}</a></li>
                        );
                    })
                }
            </ul>
        </nav>
    );
}
export default Navbar;