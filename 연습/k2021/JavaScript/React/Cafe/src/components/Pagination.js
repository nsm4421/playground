import ReactPaginate from "react-paginate";
import {Button} from 'react-bootstrap'
import {useState} from 'react'

function Pagination(props){

    let [currentPage, changeCurrentPage] = useState(1);
    let [numRecord, changeNumRecord] = useState(props.numRecord);

    return (
        <div>
          <ReactPaginate 
            pageCount={Math.ceil(numRecord)}
            pageRangeDisplayed={10}
            marginPagesDisplayed={0}
            breakLabel={""}
            previousLabel={"☜"}
            nextLabel={"☞"}
            onPageChange={(e)=>{changeCurrentPage(e.selected)}}
            containerClassName={"pagination-ul"}
            activeClassName={"currentPage"}
            previousClassName={"pageLabel-btn"}
            nextClassName={"pageLabel-btn"} 
        />
    </div>  
    )
}

export default Pagination;