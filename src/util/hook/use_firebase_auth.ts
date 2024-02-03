
import { fireAuth } from '@/data/remote/firebase'
import { useState, useEffect } from 'react'
import { User } from 'firebase/auth'

interface response {
    currentUser: User | null
    isLoading: boolean
    signOut: () => Promise<void>
}

const useFirebaseAuth = (): response => {
    const [currentUser, setCurrentUser] = useState<User | null>(null)
    const [isLoading, setIsLoading] = useState<boolean>(true)

    useEffect(() => {
        const unsubscribe = fireAuth.onAuthStateChanged((authUser) => {
            setCurrentUser(authUser ? authUser : null)
            setIsLoading(false)
        })
        return () => unsubscribe()
    }, [])

    const signOut = async (): Promise<void> => await fireAuth.signOut()

    return {
        currentUser,
        isLoading,
        signOut,
    }
}

export default useFirebaseAuth
