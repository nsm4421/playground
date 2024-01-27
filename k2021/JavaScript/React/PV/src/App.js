import {React, useEffect, useState} from 'react'
import {Link, Route,Routes, Switch, useHistory, useParams} from 'react-router-dom'

import './App.css'; 
import 'bootstrap/dist/css/bootstrap.min.css'
import ProductInfo from './components/ProductInfo';
import LoadFile from './components/LoadFile';
import Form from 'react-bootstrap'
import data from './Data'
import AddProductInfo from './components/AddProductInfo';
import Nav from './components/Nav'

function App() {  


  let [covData, changeCovData] = useState(data);  

  return (

    
    <div className="App">
      <Nav></Nav>
  
      <div> {covData.map((arr, i)=>{return <ProductInfo key={i} productInfo={arr}/>})}</div>      
      <AddProductInfo covData={covData} changeCovData={changeCovData}/>
          

    </div>


 
  );
}

export default App;
