import axios from "axios";
import { SignInSuccessResponse } from "../model/auth-model";
import { EndPoint } from "../config/end-point";

interface Props {
  email: String;
  password: String;
  onSuccess: (data: SignInSuccessResponse) => void;
  onError: () => void;
}

export default async function SignInAction(props: Props) {
  await axios
    .post(EndPoint.signin, { email: props.email, password: props.password })
    .then((res) => res.data)
    .then(props.onSuccess)
    .catch(props.onError);
}
