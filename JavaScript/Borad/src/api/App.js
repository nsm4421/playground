// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBNbSCgbgtrPSsOYgvzaWu-lU_uMKkFWMI",
  authDomain: "karma-be036.firebaseapp.com",
  databaseURL: "https://karma-be036-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "karma-be036",
  storageBucket: "karma-be036.appspot.com",
  messagingSenderId: "1041664178932",
  appId: "1:1041664178932:web:535f3a339eb92f79a9fca1"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export default app;