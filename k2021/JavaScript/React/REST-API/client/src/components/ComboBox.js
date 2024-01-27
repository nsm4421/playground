import * as React from 'react';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';

export default function ComboBox() {
  return (
    <Autocomplete
      disablePortal
      id="combo-box-demo"
      options={Position}
      sx={{ width: 300 }}
      renderInput={(params) => <TextField {...params} label="주포지션" />}
    />
  );
}
const Position = [
    '탑솔러',
    '미드',
    '백정',
    '원딜',
    '서폿'
]