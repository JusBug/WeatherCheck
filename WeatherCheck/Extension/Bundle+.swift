//
//  Bundle.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/20/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "APIKey", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            fatalError("Missing APIKEY")
        }
        
        return key
    }
}
