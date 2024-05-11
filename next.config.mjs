/** @type {import('next').NextConfig} */
const nextConfig = {
    // 구글 계정으로 회원가입한 경우, 구글에 등록된 프로필 사진을 가져오기 위해 hostname 등록
    images: {
    remotePatterns: [
      {
        hostname: "lh3.googleusercontent.com",
        protocol: "https",
      },
    ],
  },
};

export default nextConfig;
