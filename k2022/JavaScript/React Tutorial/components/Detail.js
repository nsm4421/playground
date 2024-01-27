import React from 'react'
import { Card } from '@material-ui/core'
import { CardContent } from '@material-ui/core'

class Detail extends React.Component{

    constructor(props){
        super(props)
        this.props = {

        }
    }


    render(){
        return (
            <div>
                <Card>
                    <h2>text file id : {this.props.match.params._id}</h2>
                    <CardContent>
                    
                    </CardContent>

                </Card>

                               

            </div>
        )
    }
}

export default Detail;