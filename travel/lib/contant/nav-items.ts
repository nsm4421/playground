interface NavItem {
  label: string;
  href: string;
}

const NavItems: NavItem[] = [
  {
    label: "POST",
    href: "/post",
  },
  {
    label: "Travel",
    href: "/travel",
  },
  {
    label: "CHATTING",
    href: "/chat",
  },
  {
    label: "ACTIVITY",
    href: "/activity",
  },
];

export default NavItems;
