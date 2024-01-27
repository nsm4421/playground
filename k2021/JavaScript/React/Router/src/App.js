import './App.css';
import {React, useState} from 'react';
import {Link, Route, Switch, useHistory, useParams} from 'react-router-dom'
import { Container, Nav, Navbar } from 'react-bootstrap';
import productList from './productList'

function App(){

  let [products, changeProducts] = useState(productList)

  return (
    <div className="App" style={{background:'rgb(35, 54, 53)'}}>  
    <SiteHeader/>

    <Route path="/products">
      <div className="container">
        
        <div className="row">        
            {products.map((_, i) =>{
              return <ProductInfo product={products[i]}/>
            })}            
        </div>
      </div>
    </Route>

    <Route path='/detail/:id'>
      <Detail products={products}/>
    </Route>


    </div>
  )
}

function SiteHeader(){
  return (
    <Navbar bg="light">
    <Container>
      <Navbar.Brand>React Tutorial</Navbar.Brand>
      <Nav.Link><Link to='/'>Home</Link></Nav.Link>
      <Nav.Link><Link to='/products'>Product</Link></Nav.Link>
      <Nav.Link><Link to='/detail'>Detail</Link></Nav.Link>
    </Container>
  </Navbar>
  )
}

function ProductInfo(props){
  return (
    <div className="col-md-4">
      <img className="productImage" src={props.product.src}/>
      <h4>{props.product.title}</h4>
      <p>{props.product.content}</p>
      <p>{props.product.price} 원</p>
      <hr/>
    </div>
  )
}


// 상세 페이지 UI

function Detail(props){
  
  let {id} = useParams();
  let history = useHistory();
  return (
    <div style={{color : 'white'}}>
    <img className="productImage" src={props.products[id].src}/>
    <h4>{props.products[id].title}</h4>
    <p>{props.products[id].content}</p>
    <p>{props.products[id].price} 원</p>

    <button className="btn btn-success" onClick={()=>{
      history.push('/order');
    }}>결제하기</button>

    <button className="btn btn-danger" onClick={()=>{
      history.goBack();
    }}>뒤로가기</button>
    <hr/>
    </div>
  ) 
}

export default App;