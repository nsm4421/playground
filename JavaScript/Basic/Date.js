const today = new Date();
const today_local_time_string = today.toLocaleTimeString()
const today_time_string = today.toTimeString()
const timestamp = today.getTime()

console.log(`today : ${today}`);
console.log(`today local string : ${today_local_time_string}`);
console.log(`today time string : ${today_time_string}`);
console.log(`time stamp : ${timestamp}`);