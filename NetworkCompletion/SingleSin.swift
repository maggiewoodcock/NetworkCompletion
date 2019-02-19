//
//  SingleSin.swift
//  AGData
//
//  Created by Alan Woodcock on 2/3/19.
//  Copyright © 2019 Alan Woodcock. All rights reserved.
//

import Foundation

class CalculateHeatUnit
{
    
    func SingleSinMethod(tMin: Double, tMax: Double, lowerLimit: Double, upperLimit: Double) -> Double
    {
        let degreeday: Double
        
        /*
         var tMax = 71.0
         var tMin = 32.0
         var lowerLimit = 45.0
         var upperLimit = 86.0
         */
        
        var ddlow = 0.0
        var ddhigh = 0.0
        
        let maxMinusMin = (tMax-tMin)/2.0
        let maxPlusMin = (tMax+tMin)/2.0
        //let ratio = maxMinusMin/maxPlusMin
        
        let interceptHigh = asin((upperLimit - maxPlusMin)/maxMinusMin)
        let interceptLow = asin((lowerLimit - maxPlusMin)/maxMinusMin)
        
        if tMax <= lowerLimit
        {
            ddlow = 0.0
            //print(ddlow)
        }else
        {
            if tMin >= lowerLimit
            {
                ddlow = (tMax + tMin)/2 - lowerLimit
                //print(ddlow)
            }else
            {
                ddlow =  1.0/Double.pi * ((((tMax + tMin)/2 - lowerLimit) * (Double.pi/2.0 - interceptLow ) + (tMax - tMin)/2 * cos(interceptLow )))
                //print(ddlow)
            }
            
            //IF(OR(G6="",H6=""),"",IF(G6≤D6,0,IF(H6≥D6,(G6+H6)÷2−D6,1÷PI()×((($G6+$H6)÷2−D6)×(PI()÷2−S6)+($G6−$H6)÷2×COS(S6)))))
        }
        
        if tMax <= upperLimit
        {
            ddhigh = 0.0
            //print (ddhigh)
        }else
        {
            if tMin >= upperLimit
            {
                ddhigh = (tMax+tMin)/2 - upperLimit
                //print (ddhigh)
            }else
            {
                ddhigh = 1.0/Double.pi * (((tMax+tMin)/2 - upperLimit) * (Double.pi/2 - interceptHigh) + ((tMax-tMin)/2) * cos(interceptHigh))
                //print (ddhigh)
            }
        }
        
        degreeday = ddlow - ddhigh
        return degreeday
        
    }
    
}

