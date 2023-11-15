//
//  DateManager.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/20/23.
//

import Foundation

struct DateManager {
    let current = Date()
    let dateFormatter = DateFormatter()
    
    func calculateTime(weather: WeatherData) -> String {
        let localeTimeZone = weather.timezone
        guard let timeZone = TimeZone(identifier: localeTimeZone) else {
            return "" }
        
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HH:mm"
        
        let localTime = dateFormatter.string(from: current)
        print("\(localTime)")
        
        return localTime
    }
}
