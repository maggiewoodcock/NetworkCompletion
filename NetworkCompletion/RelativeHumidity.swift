//
//  MathLib.swift
//  AGData
//
//  Created by Alan Woodcock on 2/2/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import Foundation

class RelativeHumidity{
    
    func fahrenheitToCelsius(fahrenheit: Double) -> Double
    {
        return 5.0/9.0 * (fahrenheit - 32.0)
    }
    
    func CelsiusToFahrenheit(Celsius: Double) -> Double
    {
        return (Celsius * (180/100)) + 32
    }
    
    /*
        To calculate relative humidity:
        1. convert fahrenheit(Tf) into celsius (Tc)
        2. convert dewpoint(Tdf) fahrenheit into celsius (Tdc)
        3. Calculate saturation vapor (Es)
        4. Calculate Actual vapor pressure (E)
        5. Calculate Relative Humidity (RH)
    */
    
    //3
    //Note: let result = pow(number, 2)
    func CalculateSaturationVaporPressure(airTempC: Double) -> Double //(Es)
    {
        let power = (7.5 * airTempC/(237.7 + airTempC))
        let number = 10.0
        
        let pownum = pow(number, power)
        
        return 6.11 * pownum
    }
    
    //4
    func CalculateActualVaporPressur(dewPointInC: Double) -> Double //E
    {
        let power = (7.5 * dewPointInC/(237.7 + dewPointInC))
        let number = 10.0
        
        let pownum = pow(number, power)
        
        return 6.11 * pownum
    }
    
    //5
    func calculateRelativeHumidity(SaturationVP: Double, ActualVP: Double) -> Double //(RH)
    {
        return (ActualVP/SaturationVP) * 100
    }
    

}
