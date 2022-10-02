const Page = ({page}) => {
    return (
        <div>
            {
                page.map((post, i) =>{
                    return (
                        <div key={i}>
                            <p>title : {post.title}</p>
                            <p>body : {post.body}</p>
                            <p>author : {post.username}</p>
                            <p>writeAt : {post.registerAt}</p>
                        </div>
                    )
                })
            }
        </div>
    );
};

const Pages = ({pages}) => {
    return (
        pages.map((page, i) =>{
            return (
                <div key={i}> 
                    <Page page={page}/>
                </div>
            )
        })
    )
}

export default Pages;