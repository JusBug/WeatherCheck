//
//  TemperatureConverter.swift
//  WeatherCheck
//
//  Created by Jusbug on 11/15/23.
//

import Foundation

struct TemperatureConverter {
    // 절대(켈빈) 온도를 섭씨로 변환
    static func kelvinToCelsius(_ kelvin: Double) -> Int {
        return Int((kelvin - 273.15).rounded())
    }
    
    // 절대(켈빈) 온도를 화씨로 변환
    static func kelvinToFahrenheit(_ kelvin: Double) -> Int {
        return Int(((kelvin - 273.15) * 9/5 + 32).rounded())
    }
}
