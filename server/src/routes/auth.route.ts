import { Router } from "express";
import { onSignUp, onSignIn } from "../controllers/auth.controller";

const router = Router();

router.post("/sign-up", onSignUp);

router.post("/sign-in", onSignIn);

export default router;
