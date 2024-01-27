import {  useState } from 'react';

const useError = (): [boolean, String, Function] => {
  const [isError, setIsError] = useState<boolean>(false);
  const [errorMessage, setErrorMessage] = useState<String>("");
  const handleErrorMessage = (newErrorMessage:string) => {
    setErrorMessage(newErrorMessage);
    setIsError(!(newErrorMessage === ""))
  }
  return [isError, errorMessage, handleErrorMessage];
};

export default useError;