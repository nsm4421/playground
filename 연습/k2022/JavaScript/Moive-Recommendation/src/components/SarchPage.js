import * as React from 'react';
import SearchMovie from './SarchMovie';
import MyCard from './MyCard';

export default function SearchPage(props) {
  return (
    <>
        <SearchMovie/>
        <MyCard movie_id={props.movie_id}/>
    </>
  );
}
