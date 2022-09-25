const App = () => {

  return (
    <div className="App">
      	<form action="api/v1/music" method="post" encType="multipart/form-data">
          
          <label>음악</label>
          <input type="file" name="music"></input>
          
          <label>썸네일</label>
          <input type="file" name="thumbnail"></input>
          
          <label>제출</label>
          <button type="submit">Submit</button>
        </form>      
    </div>
  );
}

export default App;
