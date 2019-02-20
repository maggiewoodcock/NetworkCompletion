//
//  JsonClass.swift
//  NetworkCompletion
//
//  Created by Alan Woodcock on 2/18/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import Foundation


class DarkSkyWeather
{
    
    public func BuildForecastUrl() -> URL {
        
        let dsurl: String = "https://api.darksky.net/forecast/"
        let apiKey: String = "926f72e7930991efbf6d7fcf2c2f428c/"
        let latitude: String = "34.967222"
        let longitude: String = "-114.605833"
        
        let string: String = dsurl + apiKey + latitude + "," + longitude
        let url = URL(string: string)
        return url!
    }
    
    //https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589,255657600
    public func BuildHistoryUrl(curDate: String) -> URL {
        
        let dsurl: String = "https://api.darksky.net/forecast/"
        let apiKey: String = "926f72e7930991efbf6d7fcf2c2f428c/"
        let latitude: String = "34.967222"
        let longitude: String = "-114.605833"
        // GetUnixTimeStampFromDate, shown below, returns a unixtimestamp as a double.
        let historyDate: Int64 = self.getUixTimeStampFromDate(currentDate: curDate)
        
        let string: String = dsurl + apiKey + latitude + "," + longitude + "," + String(historyDate)
        let url = URL(string: string)
        return url!
    }
    
    public func execNetworkRequest(url: URL, completionHandler:@escaping ([String: Any?], Error?) -> Void)
    {
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    completionHandler(jsonResponse!, nil)
                    
                    //}
                } catch {
                    //completionHandler("", error)
                    print(error.localizedDescription)
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    public func getDateFromTimeStamp(timeStamp: Double) -> String
    {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
        return dayTimePeriodFormatter.string(from: date as Date)
    }
    
    func getUixTimeStampFromDate(currentDate: String) -> Int64
    {
        
        //let stringDate = currentDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        let date = dateFormatter.date(from: currentDate)
        
        let unixTS: Int64? = Int64(date!.timeIntervalSince1970)
        
        return unixTS!
    }
    
    func ConvertFarenheitToCelcius(farenheit: Double) -> Double
    {
        return (farenheit - 32) * (5/9)
    }
    
    func ConvertCelciusToFarenheit(celcius: Double) -> Double
    {
        return (celcius * (9/5)) + 32
    }
    
    func calculateHeatStress(airTempInC: Double, uvIndex: Double, dewPointInC: Double) -> String {
        
        var heatStress = ""
        var canopyTemp = 0.0
        
        
        /* Calculate Saturated Vapor Pressure */
        var power = (7.5 * airTempInC/(237.7 + airTempInC))
        var number = 10.0
        var pownum = pow(number, power)
        let saturatedVaporPressure = 6.11 * pownum
        
        /* Calculate Actual Vapor Pressure */
        power = (7.5 * dewPointInC/(237.7 + dewPointInC))
        number = 10.0
        pownum = pow(number, power)
        let actualVaporPressure = 6.11 * pownum
        
        /* Calculate Relative Humidity */
        //let relativeHumidity = (actualVaporPressure/saturatedVaporPressure) * 100
        
        /* Calculate Vapor Pressure Deficit */
        let meanHourlyVpd = actualVaporPressure - saturatedVaporPressure
        
        /* Check for day and night */
        if uvIndex > 0 {
            canopyTemp = 0.53 + airTempInC - 1.43 * meanHourlyVpd
        }else{
            canopyTemp = (-5.93) + airTempInC + 1.95 * meanHourlyVpd
        }
        
        /* separate canopy temperature into 3 categories */
        if canopyTemp < 82.4 {
            heatStress = "NS"
        }else if canopyTemp >= 82 && canopyTemp <= 86 {
            heatStress = "HS 1"
        }else if canopyTemp > 86 {
            heatStress = "HS 2"
        }
        
         return heatStress
    }
   
}
