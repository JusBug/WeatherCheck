//
//  JSONDecoder+.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/17/23.
//

import Foundation

extension JSONDecoder {
    func decodeJSON<T: Decodable>(data: Data) -> T? {
        do {
            return try self.decode(T.self, from: data)
        } catch {
            print("JSONDecoding Error")
            return nil
        }
    }
}
