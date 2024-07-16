import { useEffect, useState } from "react";

interface Props<T> {
  initialValues: T;
  onSubmit: (input: T) => void;
  validate: (input: T) => boolean;
  delay?: number; // 광클 방지를 위해 로딩중 딜레이
}

export default function useForm<T>({
  initialValues,
  onSubmit,
  validate,
  delay,
}: Props<T>) {
  const [values, setValues] = useState(initialValues);
  const [errors, setErrors] = useState({});
  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setValues({ ...values, [name]: value });
  };

  const handleSubmit = async (e: React.SyntheticEvent) => {
    if (Object.keys(errors).length !== 0) return;
    e.preventDefault();
    try {
      setIsLoading(true);
      await new Promise((r) => setTimeout(r, delay ?? 500));
      onSubmit(values);
      setErrors(validate(values));
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  return {
    values,
    errors,
    isLoading,
    handleChange,
    handleSubmit,
  };
}
