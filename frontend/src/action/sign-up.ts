import axios from "axios";
import { EndPoint } from "../config/end-point";
import { SignUpSuccessResponse } from "../model/auth-model";

interface Props {
  email: String;
  password: String;
  onSuccess: (data: SignUpSuccessResponse) => void;
  onError: () => void;
}

export default async function SignUpAction(props: Props) {
  await axios
    .post(EndPoint.signup, { email: props.email, password: props.password })
    .then((res) => res.data)
    .then(props.onSuccess)
    .catch(props.onError);
}
