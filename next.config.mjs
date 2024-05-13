/** @type {import('next').NextConfig} */
const nextConfig = {
  // 프로필 사진을 가져오기 위해 hostname 등록
  images: {
    remotePatterns: [
      {
        hostname: "lh3.googleusercontent.com",
        protocol: "https",
      },
      {
        hostname: "avatars.githubusercontent.com",
        protocol: "https",
      },
    ],
  },
};

export default nextConfig;
