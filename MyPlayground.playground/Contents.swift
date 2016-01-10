/*:
# API Experimentation
Parsing JSON from api.wunderground.com

_C. Dixson 10 Jan 2016_

### Requirements
* Xcode 7 or higher
* Swift 2.0

*/

import Cocoa
import Foundation

let state = "RI"
let city = "02911"

let url = NSURL(string:"http://api.wunderground.com/api/[your api key]/conditions/q/\(state)/\(city).json")

do {
    let data = try NSData(contentsOfURL: url!, options: NSDataReadingOptions())
    //print(data)
    var str = NSString(data:data, encoding:NSUTF8StringEncoding)
    //print(str)
    
    let jsonData: AnyObject?
    do {
        jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        //use the rain icon for testing
        //TODO: use weather image from JSON
        if let weatherImageUrl = NSURL(string: "http://icons.wxug.com/i/c/k/rain.gif") {
            let imageDataFromURL = NSData(contentsOfURL: weatherImageUrl)
            let image = NSImage(data:imageDataFromURL!)
        }
        
        let weatherInfo = jsonData!["current_observation"] as! NSDictionary
        let currentTemp = weatherInfo["temperature_string"] as! NSString
        let observationTime = weatherInfo["observation_time_rfc822"] as! NSString
        let currentCity = weatherInfo["display_location"]!["full"] as! NSString
        
        print(currentCity, currentTemp, "\nObservation as of:", observationTime)
        
    } catch  {
        print(error)
    }
} catch {
    print(error)
}
