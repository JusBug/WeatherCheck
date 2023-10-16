//
//  Weather.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/17/23.
//

// JSON 데이터를 파싱하기 위한 루트 데이터 모델
struct WeatherData: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let minutely: [MinutelyPrecipitation]
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

// 현재 날씨 정보
struct CurrentWeather: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let tmep: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [WeatherInfo]
}

// 분 단위 강수량 정보
struct MinutelyPrecipitation: Decodable {
    let dt: Int
    let precipitation: Double
}

// 시간별 날씨 정보
struct HourlyWeather: Decodable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [WeatherInfo]
    let pop: Double
}

// 일별 날씨 정보
struct DailyWeather: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let summary: String
    let temp: Temperature
    let feels_like: Temperature
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [WeatherInfo]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
}

// 온도 정보
struct Temperature: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// 날씨 정보
struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
