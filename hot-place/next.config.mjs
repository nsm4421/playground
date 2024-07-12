/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images:{
    domains: [`${process.env.SUPBASE_USERNAME}.supabase.co`],
  }
};

export default nextConfig;
