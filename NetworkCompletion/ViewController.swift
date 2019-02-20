//
//  ViewController.swift
//  NetworkCompletion
//
//  Created by Alan Woodcock on 2/13/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import UIKit

struct DailyDarkSkyStructForecast {
    var currentDate: String = ""
    var temperatureMax: Double = 0.0
    var temperatureMin: Double = 0.0
    var precipitationIntensityMax: Double = 0.0
    var heatUnit: Double = 0.0
}

struct HourlyDarkSkyStructForecast {
    var currentDate: String = ""
    var temperature: Double = 0.0
    var precipitationIntensity: Double = 0.0
    var dewPoint: Double = 0.0
    var humidity: Double = 0.0
    var uvIndex: Double = 0.0
    var heatStress: String = ""
}

class ViewController: UIViewController {
    
    @IBAction func DailyForecast(_ sender: UIBarButtonItem)
    {
        let jc = DarkSkyWeather()
        
        //Build the forecast url
        let url = jc.BuildForecastUrl()
        
        //Example: https://api.darksky.net/forecast/926f72e7930991efbf6d7fcf2c2f428c/34.967222,-114.605833
        
        jc.execNetworkRequest(url: url) { jsonPayload, error in
            DispatchQueue.main.async
                {
                    
                    var ds = DailyDarkSkyStructForecast()
                    var arr = [DailyDarkSkyStructForecast]()
                    let dict = jsonPayload
                    let daily = dict["daily"]! as? NSDictionary
                    let data = daily!["data"]! as? [[String: Any]]
                    
                    
                    /* there are, at this time, 8, days in the forecast. */
                    self.textView.text = ""
                    for d in data!
                    {
                        
                        if d["time"] != nil
                        {
                            ds.currentDate = jc.getDateFromTimeStamp(timeStamp: (d["time"] as? Double)!)
                        }
                        
                        if d["temperatureMin"] != nil
                        {
                            ds.temperatureMin = (d["temperatureMin"]! as? Double)!
                        }
                        
                        if d["temperatureMax"] != nil
                        {
                            ds.temperatureMax = (d["temperatureMax"]! as? Double)!
                        }
                        
                        if d["precipitationIntensityMax"] != nil
                        {
                            ds.precipitationIntensityMax = (d["precipitationIntensityMax"]! as? Double)!
                        }

                        arr.append(ds)
                        
                        self.textView.insertText("Forecast Date: \(ds.currentDate)\n")
                        self.textView.insertText("Minimum Temperature: \(ds.temperatureMin)\n")
                        self.textView.insertText("Maximum Temperature: \(ds.temperatureMax)\n")
                        self.textView.insertText("Maximum Precipitation Intensity: \(ds.precipitationIntensityMax)\n")
                        let cHU = CalculateHeatUnit()
                        var heatUnit = cHU.SingleSinMethod(tMin: ds.temperatureMin, tMax: ds.temperatureMax, lowerLimit: 55, upperLimit: 86)
                        self.textView.insertText("Heat Unit: \(heatUnit)\n")
                        self.textView.insertText("\n")
                        
                        
                    }
            }
        }
    }
    
    @IBAction func HourlyForecast(_ sender: UIBarButtonItem) {
        
        let jc = DarkSkyWeather()
        
        //Build the forecast url
        let url = jc.BuildForecastUrl()
        
        jc.execNetworkRequest(url: url) { jsonPayload, error in
            DispatchQueue.main.async
                {
                    
                    var ds = HourlyDarkSkyStructForecast()
                    var arr = [HourlyDarkSkyStructForecast]()
                    
                    let dict = jsonPayload
                    let hourly = dict["hourly"]! as? NSDictionary
                    let data = hourly!["data"]! as? [[String: Any]]
                    
                    /* there are, at this time, 8, days in the forecast. */
                    self.textView.text = ""
                    for d in data!
                    {
                        
                        if d["time"] != nil
                        {
                            ds.currentDate = jc.getDateFromTimeStamp(timeStamp: (d["time"] as? Double)!)
                        }
                        
                        if d["temperature"] != nil
                        {
                            ds.temperature = (d["temperature"]! as? Double)!
                        }
                        
                        if d["precipitationIntensity"] != nil
                        {
                            ds.precipitationIntensity = (d["precipitationIntensity"]! as? Double)!
                        }
                        
                        if d["dewPoint"] != nil
                        {
                            ds.dewPoint = (d["dewPoint"]! as? Double)!
                        }
                        
                        if d["humidity"] != nil
                        {
                            ds.humidity = (d["humidity"]! as? Double)!
                        }
                        
                        if d["uvIndex"] != nil
                        {
                            ds.uvIndex = (d["uvIndex"]! as? Double)!
                        }
                        
                        let airTempInc = jc.ConvertFarenheitToCelcius(farenheit: ds.temperature)
                        let dewPointInC = jc.ConvertFarenheitToCelcius(farenheit: ds.dewPoint)
    
                        ds.heatStress = jc.calculateHeatStress(airTempInC: airTempInc, uvIndex: ds.uvIndex , dewPointInC: dewPointInC)
                        
                        arr.append(ds)
                        
                        self.textView.insertText("Forecast Date: \(ds.currentDate)\n")
                        self.textView.insertText("Temperature: \(ds.temperature)\n")
                        self.textView.insertText("Precipitation Intensity: \(ds.precipitationIntensity)\n")
                        self.textView.insertText("Dew Point: \(ds.dewPoint)\n")
                        self.textView.insertText("Humidity: \(ds.humidity)\n")
                        self.textView.insertText("UV Index: \(ds.uvIndex)\n")
                        self.textView.insertText("Heat Stress: \(ds.heatStress)\n")
                        self.textView.insertText("\n")
                    }
            }
        }
    }
    
    
    @IBOutlet weak var textView: UITextView!
    
    
}
    

