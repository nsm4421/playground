const textUtil = (maxLen, setter) => (e) => {
    let v = e.target.value;
    if (v.length > maxLen){
        v = v.slice(0, Math.min(v.length, maxLen));
    }
    setter(v);
}

export default textUtil;