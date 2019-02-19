//
//  HeatStress.swift
//  AGData
//
//  Created by Alan Woodcock on 2/3/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import Foundation

class CanopyTemperature {
    
    
    func CalculateCTDayTime(meanHourlyTemp: Double, meanHourlyVpd: Double) -> Double {
        let CTAh = 0.0
        
        
        return CTAh
    }
    
    func CalculateCTNightTime(meanHourlyTemp: Double, meanHourlyVp: Double) -> Double {
        let CTPh = 0.0
        
        
        return CTPh
    }
    
    // Daily Canopy temperature is converted to fahrenheit before calling this function.
    func CalculateHeatStress(dailyCanopyTemperature: Double, solarRadiation: Double) -> String{
        let heatStress = ""
        
        return heatStress
    }

}
