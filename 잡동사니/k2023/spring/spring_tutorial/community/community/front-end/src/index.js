import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { BrowserRouter } from 'react-router-dom';
import {
    RecoilRoot,
    atom,
} from 'recoil';

export const initUserState = {
    key: 'user',
    default: {
        nickname:null,
        kakao:{
            id:null,
            connected_at:null,
            email:null,
            nickname:null,
            profile_image_url:null,
            thumbnail_image_url:null,
            token:null
        }
    },
}

export const userState = atom(initUserState);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
    <React.StrictMode>
        <BrowserRouter>
            <RecoilRoot>
                <App />
            </RecoilRoot>
        </BrowserRouter>
    </React.StrictMode>
);

reportWebVitals();
