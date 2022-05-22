import { Fab, Tooltip } from "@mui/material";
import { EditRounded } from "@mui/icons-material";

const FloatingActionButton = ()=>{
    return (
        <div>
            <Tooltip title="Write Post">
                <Fab color="secondary">
                    <EditRounded />
                </Fab>
            </Tooltip>
        </div>
    )
}

export default FloatingActionButton;