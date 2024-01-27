import * as React from 'react';
import Card from '@mui/material/Card';
import CardMedia from '@mui/material/CardMedia';
import CardContent from '@mui/material/CardContent';
import AddCircleIcon from '@mui/icons-material/AddCircle';
import Typography from '@mui/material/Typography';


const Header = ({menu})=>{
  return (
    <div className="Card-Header">
      <h3>{menu}</h3>
      <button  className='Card-Header-Icon'>
        <AddCircleIcon/>
      </button>
    </div>
  )
}

const SingleCoffeeCard= ({menu, price, imgSrc, description}) => {
  return (
    <Card sx={{ maxWidth: '100%' }}>
            
      {/* 헤더 */}
      <Header menu={menu}/>

      {/* 썸네일 */}
      <CardMedia
        component="img"
        sx={{
          bgcolor: 'background.paper',
          boxShadow: 1,
          borderRadius: 2,
          p: 2,
          width : '90%',
          display:'inline-block'
        }}
        src={imgSrc}
      />

      <CardContent>
        {/* 메뉴설명 */}
        <Typography variant="body" color="text.primary">
          {description}
        </Typography>
        {/* 가격 */}
        <Typography variant="body2" color="text.secondary">
        <br/>
          {price}원
        </Typography>
      </CardContent>
        
    </Card>
  );
}

const CoffeeCard = (props)=>{
  return(
    <div className='CoffeeCard-Container'>
      <SingleCoffeeCard menu="Americano" price={7000} 
    imgSrc={process.env.PUBLIC_URL+'/img/latte.jpg'}
    description={'시원한 아이스 아메리카노'}/>
      <SingleCoffeeCard menu="Americano" price={7000} 
    imgSrc={process.env.PUBLIC_URL+'/img/latte.jpg'}
    description={'시원한 아이스 아메리카노'}/>
      <SingleCoffeeCard menu="Americano" price={7000} 
    imgSrc={process.env.PUBLIC_URL+'/img/latte.jpg'}
    description={'시원한 아이스 아메리카노'}/>
    </div>
  )
}

export default CoffeeCard;
