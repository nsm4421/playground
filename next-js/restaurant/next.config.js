/** @type {import('next').NextConfig} */
const nextConfig = {
  env: {
    BASE_URL: process.env.BASE_URL,
  },
  images: {
    domains: ['s3-karma-restauarnt.s3.ap-northeast-2.amazonaws.com'],
  },
}

module.exports = nextConfig
