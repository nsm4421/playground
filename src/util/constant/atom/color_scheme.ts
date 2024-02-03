import { atom } from "recoil"

type ColorScheme = "light" | "dark"

const colorScheme = atom<ColorScheme>({
    key: "color-shceme",
    default: localStorage.getItem("color-sheme") as ColorScheme || "light"
})

export default colorScheme