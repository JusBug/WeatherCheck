//
//  APIManager.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/17/23.
//

import Foundation

struct APIManager {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&appid=03ada23dedd4e921f88e7fba1275c322") else {
            print("Wrong URL")
            completion(.failure(APIError.wrongURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            
            if let error = error {
                completion(.failure(error))
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Response Error")
                    completion(.failure(APIError.responseError))
                    return
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    print("Server Error: \(httpResponse.statusCode)")
                    completion(.failure(APIError.serverError))
                    return
                }
                
                guard let safeData = data else {
                    print("No Data")
                    completion(.failure(APIError.noData))
                    return
                }
                
                print(safeData)
                completion(.success(safeData))
            }
        }
        
        dataTask.resume()
    }
}
