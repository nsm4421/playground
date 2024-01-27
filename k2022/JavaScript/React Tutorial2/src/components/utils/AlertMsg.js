import Alert from '@mui/material/Alert';
import Stack from '@mui/material/Stack';


export default function AlertMsg(props){

    // serverity : error / warining / info / success

    return (
        <Stack sx={{ width: '100%' }} spacing={2}>
            <Alert severity={props.severity}>{props.message}</Alert>
        </Stack>           
    )
}