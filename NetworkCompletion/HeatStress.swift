//
//  HeatStress.swift
//  AGData
//
//  Created by Alan Woodcock on 2/3/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import Foundation

class CanopyTemperature {
    
    /* Day time */
    func CalculateCTDayTime(meanHourlyTemp: Double, meanHourlyVpd: Double) -> Double
    {
        return 0.53 + meanHourlyTemp - 1.43 * meanHourlyVpd
    }
    
    func CalculateCTNightTime(meanHourlyTemp: Double, meanHourlyVp: Double) -> Double {
        return (-5.93) + meanHourlyTemp + 1.95 * meanHourlyVp
    }
    
    // Daily Canopy temperature is converted to fahrenheit before calling this function.
    func CalculateHeatStress(dailyCanopyTemperature: Double, solarRadiation: Double) -> String{
        let heatStress = ""
        
        return heatStress
    }

}
