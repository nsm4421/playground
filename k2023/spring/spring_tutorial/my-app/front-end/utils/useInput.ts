import { useCallback, useState, SetStateAction, Dispatch, ChangeEvent } from 'react';

const useInput = <T>(initValue: T): [T, Dispatch<SetStateAction<T>>, (e: ChangeEvent<HTMLInputElement>) => void] => {
  const [value, setValue] = useState(initValue);
  const onChange = useCallback((e: ChangeEvent<HTMLInputElement>) => {
    setValue(e.target.value as unknown as T);
  }, []);
  return [value, setValue, onChange];
};

export default useInput;