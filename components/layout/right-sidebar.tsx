import Image from "next/image";

export default function RightSidebarComponent() {
  return (
    <div className="right-sidebar">
      <div className="mt-10 flex">
        <Image
          src={"assets/tag.svg"}
          alt={"notification"}
          width={25}
          height={25}
        />
        <h3 className="font-bold ml-2">Notifications</h3>
      </div>
    </div>
  );
}
