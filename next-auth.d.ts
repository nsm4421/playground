import NextAuth from 'next-auth'

// Refernce : https://next-auth.js.org/getting-started/typescript
declare module 'next-auth' {

    interface Session {
        user: {
            id: string;
            name?: string;
            email: string;
            image?: string;
        }
    }
}
