import { Dispatch, SetStateAction } from "react"
import { EditorState } from "draft-js"
import dynamic from "next/dynamic"
import { EditorProps } from "react-draft-wysiwyg"
import 'react-draft-wysiwyg/dist/react-draft-wysiwyg.css'

const Editor = dynamic<EditorProps>(
    ()=>import('react-draft-wysiwyg').then((module)=>module.Editor),
    {
        ssr:false
    }
)

export default function MyEditor({
    editorState, 
    readOnly=false,
    onSave,
    onEditorStateChange
    }
    :{
        editorState:EditorState, 
        readOnly?:boolean,
        onSave?:()=>void,
        onEditorStateChange?:Dispatch<SetStateAction<EditorState|undefined>>
    }){
    return (
        <div>
            <Editor 
                readOnly={readOnly}
                toolbarHidden={readOnly}
                editorState={editorState}
                toolbarClassName="editor-toolbar-hidden"
                wrapperClassName="wrapper-class"
                editorClassName="editor-class"
                toolbar={{
                    options:['inline', 'list', 'textAlign', 'link']
                }}
                localization={{
                    local:'ko'
                }}
                onEditorStateChange={onEditorStateChange}
            />

            {readOnly?? <button onClick={onSave}>Save</button>}
        </div>
    )
}
