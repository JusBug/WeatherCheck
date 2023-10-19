//
//  URLManager.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/20/23.
//

import Foundation

final class URLManager {
    static let shared = URLManager()
    var selectedDate: Date?
    private init() {}
    
    func configureURLSession(latitude: Double, longitude: Double, apiKey: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/3.0/onecall"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        return urlComponents.url
    }
}
