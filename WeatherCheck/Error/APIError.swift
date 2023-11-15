//
//  APIError.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/17/23.
//

enum APIError: Error {
    case wrongURL
    case responseError
    case serverError
    case noData
}
