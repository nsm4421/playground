import MyEditor from '../../../components/Editor'
import { EditorState, convertFromRaw, convertToRaw } from 'draft-js'
import { useRouter } from 'next/router'
import { useState, useEffect } from 'react'

export default function EditProduct() {
  const router = useRouter()
  const {id:productId, edit} = router.query
  const [editorState, setEditorState] = useState<EditorState|undefined>(undefined)
  const [readOnly, setReadOnly] = useState<boolean>(false);  

  // edit모드 & productId가 존재 → 수정가능
  useEffect(()=>{
    setReadOnly(!(edit&&productId))
  }, [edit])

  useEffect(()=>{
    if (productId == null){
      return
    }
    // 상품 정보 가져오기
    const endPoint = `/api/get-product?id=${productId}`
    fetch(endPoint)
      .then(res=>res.json())
      .then(data => data.data.description)
      .then((description) => {
        description
        // description 필드의 값이 기존에 있는 경우 → update state
        ?setEditorState(EditorState.createWithContent(convertFromRaw(JSON.parse(description))))
        // description 필드의 값이 기존에 없는 경우 → Empty State
        :setEditorState(EditorState.createEmpty())        
      })
      .catch(err=>console.error(err))
  }, [productId])

  // 수정내용 저장
  const handleSave = () => {
   if (!editorState){
    return
   }
   fetch('/api/update-product', {
    method:'POST',
    body: JSON.stringify({
      id : productId,
      description : JSON.stringify(convertToRaw(editorState.getCurrentContent()))
    })
   }).then(res=>res.json())
   .then((data)=>{
      alert(data.message)
      return;
   }).catch(err=>console.error(err))
  }


  return (
    <>
      {editorState!=null &&
            (
              <MyEditor
              editorState={editorState}
              onSave = {handleSave}
              onEditorStateChange = {setEditorState}
              readOnly={readOnly}
            />
            )
      }

      {/* edit모드인 경우에만 저장버튼 보이기 */}
      {
        !readOnly&&<button onClick={handleSave}>Save</button>
      }      
    </>
  )
}
