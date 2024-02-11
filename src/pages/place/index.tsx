export default function test(){
// Check if the Geolocation API is supported by the browser
if ("geolocation" in navigator) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        
        console.log("Latitude:", latitude);
        console.log("Longitude:", longitude);
        
        // Now you can use the latitude and longitude to do something, like displaying on a map
      },
      (error) => {
        // Handle permission denied or other errors
        if (error.code === error.PERMISSION_DENIED) {
          console.error("User denied the request for Geolocation.");
        } else {
          console.error("Error getting location:", error.message);
        }
      }
    );
  } else {
    console.error("Geolocation is not supported by this browser.");
  }
  
  

    return <div>
        <h1>test</h1>
        
    </div>
}