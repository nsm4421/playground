import { useState } from "react";
import './App.css';
import Download from './components/Download';
import MetaData from './components/MetaData';
import NavigateButton from './components/NavigateButton';
import Mp4FileList from './components/Mp4FileList';
import { Routes, Route } from 'react-router-dom';

function App() {
  /**
   * States
   * ytLink : 유튜브 링크
   * isAudio : 영상을 다운 받을지, 오디오를 다운 받을지 여부
   * metaData : 유튜브 영상 메타데이터(제목, 영상길이, 썸네일, 조회수, 설명)
   * mp4Files : 내가 다운 받은 유튜브 영상 List
   */
  const [ytLink, setYtLink] = useState("");
  const [isAudio, setIsAudio] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [metaData, setMetaData] = useState({
    title:"", length:"", thumbnail:"", numView:"", description:""
  });
  const [mp4Files, setMp4Files] = useState([]);
  return (
    <div className="App p-4">

      {/* 상단 네비게이션바 */}
      <NavigateButton/>

      {/* 라우팅 */}
      <Routes>
        
        {/* download 경로 → 다운로드 화면, 메타데이터 화면 */}
        <Route path="/download" element={
            <div>
              <Download ytLink={ytLink} setYtLink={setYtLink} isAudio={isAudio} setIsAudio={setIsAudio} isLoading={isLoading} setIsLoading={setIsLoading}/>
              <MetaData ytLink={ytLink} isAudio={isAudio} metaData={metaData} setMetaData={setMetaData} isLoading={isLoading}/>
            </div>
          }></Route>

        {/* my 경로 → 내가 다운 받은 영상 화면 */}
        <Route path="/my" element={
              <Mp4FileList mp4Files={mp4Files} setMp4Files={setMp4Files}/>
            }></Route>

      </Routes>    
    </div>
  );
}

export default App;
