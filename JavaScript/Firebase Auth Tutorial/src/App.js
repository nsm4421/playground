import './App.css';
import EmailAndPasswordSignUp from './EmailAndPasswordSignUp'
import EmailAndPasswordLogin from './EmailAndPasswordLogin';
import LocalStorageExmaple from './LocalStorageExmaple';
import GoogleAccountSignUpPopUp from './GoogleAccountSignUpPopUp';
import LogOut from './LogOut';

function App() {
  return (
    <div className="App">
      <EmailAndPasswordSignUp/>
      <EmailAndPasswordLogin/>
      <LocalStorageExmaple/>
      <GoogleAccountSignUpPopUp/>
      <LogOut/>
      
    </div>
  );
}

export default App;
