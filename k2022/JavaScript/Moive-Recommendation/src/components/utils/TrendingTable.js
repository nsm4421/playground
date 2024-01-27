import * as React from 'react';
import { styled } from '@mui/material/styles';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import WhatIsGenre from './WhatIsGenre';

const StyledTableCell = styled(TableCell)(({ theme }) => ({
  [`&.${tableCellClasses.head}`]: {
    backgroundColor: theme.palette.common.black,
    color: theme.palette.common.white,
  },
  [`&.${tableCellClasses.body}`]: {
    fontSize: 14,
  },
}));

const StyledTableRow = styled(TableRow)(({ theme }) => ({
  '&:nth-of-type(odd)': {
    backgroundColor: theme.palette.action.hover,
  },
  // hide last border
  '&:last-child td, &:last-child th': {
    border: 0,
  },
}));

function MyTableHeader(props){
    return (
        <>
        <TableHead>
            <TableRow>
                {
                    props.headers.map((header, idx)=>{
                        return(
                            <StyledTableCell key={idx} align="center">{header}</StyledTableCell>
                        )
                    })
                }
            </TableRow>
        </TableHead>
        </>
    )
}

function MyTableRow(props){

  const genre_list = WhatIsGenre(props.item.genre_ids)
  let genre_repr = ""
  if (genre_list){
    genre_list.forEach((g)=>{genre_repr=genre_repr+" | "+g})
  } else{
    genre_repr = "NAN"
  }

  return (    
      <StyledTableRow>   
        <StyledTableCell align="right">{props.item.title}</StyledTableCell>
        <StyledTableCell align="right">{props.item.adult?"Y":"N"}</StyledTableCell>
        <StyledTableCell align="right">{genre_repr}</StyledTableCell>
        <StyledTableCell align="right">{props.item.release_date}</StyledTableCell>
        <StyledTableCell align="right">{props.item.vote_average}</StyledTableCell>
        <StyledTableCell align="right">{props.item.vote_count}</StyledTableCell>
        <StyledTableCell align="right">{props.item.overview}</StyledTableCell>
      </StyledTableRow>      
  )
}



export default function TrendingTable(props) {

  const headers =  ["제목", "19금", "장르","개봉일","평점","투표수","줄거리"]

  return (
    <TableContainer component={Paper}>
      <Table sx={{ minWidth: 700 }} aria-label="customized table">
        
        {/* Header */}
        <MyTableHeader headers={headers}/>

        {/* Body */}
        <TableBody>
          {props.items.map((item, idx) => {
              return (
                <MyTableRow key={idx} item={item}/>
              )
          })}
        </TableBody>

      </Table>
    </TableContainer>
  );
}
