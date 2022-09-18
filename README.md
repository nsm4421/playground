# SNS


### API

> api/v1/user/register

    - POST
    - 회원가입

> api/v1/user/login

    - POST
    - 로그인

> api/v1/user/check/is-exist-username	

    - POST
    - 유저명 중복여부

> api/v1/user/check/is-exist-email

    - POST
    - 이메일 중복여부

> api/v1/post

    - GET
    - 전체 게시글 목록 조회


> api/v1/post/my-post

    - GET
    - 내가 작성한 게시글 목록 조회


> api/v1/post/{postId}

    - GET    	
        - 특정 게시글 조회
    - POST	
        - 게시글 작성
    - PUT	
        - 게시글 수정
    - DELETE	
        - 게시글 삭제

> api/v1/post/{postId}/like	

    - GET	
        - 좋아요 개수 조회
    - POST	
        - 좋아요
		
> api/v1/post/{postId}/comment	
        
    - GET	
        - 댓글 조회
    - POST	
        - 댓글 작성
