type CustomApiResopnse = {
  status: boolean;
  message?: string;
  data?: any;
};

export function success(props: { message?: string; data?: any }) {
  const res: CustomApiResopnse = {
    status: true,
    message: props.message ?? "Success",
    data: props.data ?? null,
  };
  return new Response(JSON.stringify(res));
}

export function failure(props: { message?: string; data?: any }) {
  const res: CustomApiResopnse = {
    status: true,
    message: props.message ?? "Fail",
    data: props.data ?? null,
  };
  return new Response(JSON.stringify(res));
}
