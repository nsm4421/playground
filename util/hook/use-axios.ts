import defaultAxios from 'axios'
import { useEffect, useState } from 'react'

interface AxiosState<T = any> {
  isLoading: boolean
  error: any
  data: T
}

interface AxiosOption<T = any> {
  url: string
  method?: 'GET' | 'POST' | 'PUT' | 'DELETE'
  data?: T
}

export default function useAxios<T>(
  opts: AxiosOption,
  axiosInstance = defaultAxios
) {
  // state
  const [state, setState] = useState<AxiosState>({
    isLoading: true,
    error: null,
    data: null,
  })
  const [lastUpdated, setLastUpdated] = useState<number>(0)

  // check end point
  if (!opts.url) throw new Error('end point is not given')

  // when state(lastUpated) chages, fetch data again
  const refetch = () => {
    setState({ ...state, isLoading: true })
    setLastUpdated(Date.now())
  }
  useEffect(() => {
    axiosInstance(opts)
      .then((data) => {
        setState({
          ...state,
          isLoading: false,
          data: data.data,
        })
      })
      .catch((error) => {
        setState({ ...state, isLoading: false, error })
      })
  }, [lastUpdated])

  return { ...state, refetch }
}
