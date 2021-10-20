import * as React from 'react';
import Checkbox from '@mui/material/Checkbox';
import FormGroup from '@mui/material/FormGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';

class SingleCheckBox extends React.Component{
    render(){
        return (
            <div>
                <FormControlLabel
                control={<Checkbox/>}
                label={this.props.position}
                labelPlacement="top"/>
            </div>
        )         
    }
}

export default function CheckBox() {

  return (
    <div>
    <FormControl component="fieldset">
        
        <FormLabel component="legend">주포지션</FormLabel>
        
        <FormGroup aria-label="position" row>

            <SingleCheckBox position = "탑"/>
            <SingleCheckBox position = "미드"/>            
            <SingleCheckBox position = "원딜"/>            
            <SingleCheckBox position = "정글"/>            
            <SingleCheckBox position = "서폿"/>

        </FormGroup>
    </FormControl>
    </div>

  );
}