import { createContext } from "react";

const valueToShare = 'value to share'
type myProviderProps = {
    children:React.ReactNode
}
export const myContext = createContext(valueToShare)
export const MyProvider = ({children}:myProviderProps) => {
    return <myContext.Provider value={valueToShare}>{children}</myContext.Provider>
}