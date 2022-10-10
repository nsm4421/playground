const logout = () => {
    localStorage.removeItem("token");
    navigator("/");
}

export default logout;