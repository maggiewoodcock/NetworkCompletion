//
//  ViewController.swift
//  NetworkCompletion
//
//  Created by Alan Woodcock on 2/13/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import UIKit

struct DarkSkyStruct {
    var currentDate: String = ""
    var temperatureMax: Double = 0.0
    var temperatureMin: Double = 0.0
    var precipitationIntensityMax: Double = 0.0
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func executeNetworkRequest(_ sender: UIButton)
    {
        // DarkSkyWeather object
        let jc = DarkSkyWeather()
        
        //Build the forecast url
        let url = jc.BuildForecastUrl()
        
        jc.execNetworkRequest(url: url) { jsonPayload, error in
        DispatchQueue.main.async
            {
        
            var ds = DarkSkyStruct()
            var arr = [DarkSkyStruct]()
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
                self.textView.insertText("\n")
                }
            }
        }
    }
}
    

