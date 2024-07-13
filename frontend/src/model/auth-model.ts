export type UserModel = {
  username: String;
  email: String;
  role?: String;
};

export type SignUpSuccessResponse = {
  message: string;
  data: string; // jwt
};

export type SignInSuccessResponse = {
  message: string;
  data: {
    jwt: string;
    account: {
      email: string;
      username: string;
      role: string;
    };
  };
};
