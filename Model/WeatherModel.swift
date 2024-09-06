import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    let timezone: Double
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

struct Sys: Decodable {
    let sunset: Int
    let sunrise: Int
}

