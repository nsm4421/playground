import browserClient from "../supabase/browser-client";

interface Props {
  nickname: string;
  profileImage: File;
}

export default async function editProfileAction({
  nickname,
  profileImage,
}: Props) {
  // 인증정보 확인하기
  const {
    data: { user },
  } = await browserClient.auth.getUser();

  if (!user) {
    throw Error("user is not logined");
  }

  // 프로필 이미지 저장
  const filename = `public/profile_image_${user.id}.jpg`;
  const { error } = await browserClient.storage
    .from("profile-image")
    .upload(filename, profileImage, {
      upsert: true,
      cacheControl: "3600",
    });
  if (error) {
    throw Error("upload profile image fail");
  }

  // public url 가져오기
  const {
    data: { publicUrl },
  } = browserClient.storage.from("profile-image").getPublicUrl(filename);

  // 유저정보 저장
  await browserClient
    .from("account")
    .upsert({
      nickname: nickname,
      profile_image: publicUrl,
    })
    .eq("id", user.id);

  user.user_metadata;
  
  // auth 업데이트
  await browserClient.auth.updateUser({
    data: {
      ...user.user_metadata,
      nickanme: nickname,
      profile_image: publicUrl,
    },
  });
}
