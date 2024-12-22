import { Router } from "express";
import onSignUp from "../controllers/auth/sign-up.controller";
import onSignIn from "../controllers/auth/sign-in.controller";

const router = Router();

router.post("/sign-up", onSignUp);
router.post("/sign-in", onSignIn);

export default router;
