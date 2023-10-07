type item = {
  imgSrc: string;
  label: string;
  href: string;
};

const sideBarItems: item[] = [
  {
    imgSrc: "/assets/home.svg",
    label: "Home",
    href: "/",
  },
  {
    imgSrc: "/assets/search.svg",
    label: "Search",
    href: "/search",
  },
  {
    imgSrc: "/assets/create.svg",
    label: "Write",
    href: "/create",
  },
  {
    imgSrc: "/assets/community.svg",
    label: "Community",
    href: "/community",
  },
  {
    imgSrc: "/assets/user.svg",
    label: "Profile",
    href: "/profile",
  },
];

export default sideBarItems;
