"use client";

import useAuth from "@/lib/store/auth/auth_state";
import {
  faGear,
  faPenToSquare,
  faSignOut,
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  Avatar,
  Dropdown,
  DropdownItem,
  DropdownMenu,
  DropdownTrigger,
} from "@nextui-org/react";

export default function UserButton() {
  const { user, signOut } = useAuth();

  /* TODO : 프로필 수정, 마이페이지 기능 만들기 */
  const handleGoEditPage = () => {};
  const handleGoSettingPage = () => {};

  const handleSignOut = async () => await signOut();

  return (
    <Dropdown className="cursor-pointer text-black dark:text-white">
      <DropdownTrigger>
        <Avatar
          src={user?.user_metadata.profile_image}
          name={user?.user_metadata.nickname ?? "?"}
        />
      </DropdownTrigger>
      <DropdownMenu aria-label="Static Actions" onClick={handleGoEditPage}>
        <DropdownItem key="edit">
          <div className="flex items-center justify-start">
            <FontAwesomeIcon className="w-3 h-3 p-2" icon={faPenToSquare} />
            <label>Edit Profile</label>
          </div>
        </DropdownItem>
        <DropdownItem key="setting" onClick={handleGoSettingPage}>
          <div className="flex items-center justify-start">
            <FontAwesomeIcon className="w-3 h-3 p-2" icon={faGear} />
            <label>Setting</label>
          </div>
        </DropdownItem>
        <DropdownItem
          key="sign-out"
          className="text-danger"
          color="danger"
          onClick={handleSignOut}
        >
          <div className="flex items-center justify-start">
            <FontAwesomeIcon className="w-3 h-3 p-2" icon={faSignOut} />
            <label>Sign Out</label>
          </div>
        </DropdownItem>
      </DropdownMenu>
    </Dropdown>
  );
}
