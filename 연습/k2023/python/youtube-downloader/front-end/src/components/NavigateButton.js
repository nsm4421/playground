export default function NavigateButton(){
    return (
        <div className="d-flex justify-content-between">

        <h1 className="d-flex"><a href="#">Youtube Downloader</a></h1>

        <div className="d-flex align-items-center">
          <button type="button" className="btn btn-warning me-2"><a href="/download">다운로드하러 가기</a></button>
          <button type="button" className="btn btn-success me-2"><a href="/my">내가 받은 영상</a></button>
        </div>

      </div>
    )
}