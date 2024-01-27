/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    // Image domains to permit
    domains: ['picsum.photos'],
  },
}

module.exports = nextConfig
