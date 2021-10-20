import * as React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';


class BasicTable extends React.Component {
  
  state(){
    ""
  }

  componentDidMount(){
    this.callAPI()
    .then(res=>this.setState({data:res}))
    .catch(err=>console.log(err));
  }

  callAPI = async()=>{
    const response = await fetch('http://127.0.0.1:5000/test');
    const body = await response.json(); 
    return body;
  }

  render(){
      return (
          <div>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>롤 아이디</TableCell>
                <TableCell align="right">아이디</TableCell>
                <TableCell align="right">포지션</TableCell>
                <TableCell align="right">인사말</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {this.state.data? this.state.data.map((row) => (
                <TableRow
                  key={row.lol_id}
                  sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    {row.lol_id}
                  </TableCell>
                  <TableCell align="right">{row.user_id}</TableCell>
                  <TableCell align="right">{row.position}</TableCell>
                  <TableCell align="right">{row.greeting}</TableCell>
                  </TableRow>
              )):""}              
            </TableBody>
          </Table>
        </TableContainer>
          </div>
      );
      
  }
}


export default BasicTable;