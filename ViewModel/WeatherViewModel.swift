//WeatherViewModel.swift
import UIKit
import Alamofire

class WeatherViewModel {
    
    var cityName = "Kursk"
    var temperature = "123"
    var weatherDescription = "123"
    
    let apiKey = Secrets.apiKey
    
    
    
    //carrying out request using Alamofire and coordinates
    func getWeather(latitude: Double, longitude: Double, completion: @escaping () -> Void) {
        
        let urlString  = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        AF.request(urlString).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                self.cityName = weatherResponse.name
                self.temperature = String(format: "%.1f°C", weatherResponse.main.temp)
                self.weatherDescription = weatherResponse.weather.first?.description ?? ""
                
                // UI update
                DispatchQueue.main.async {
                    completion()
                }
                //
                
            case .failure(let error):
                print("Ошибка получения данных о погоде: \(error)")
            }
        }
    }
    
    func getWeather(for city: String, completion: @escaping () -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        //print(urlString)
        
        //carrying out request using Alamofire and name of the city
        AF.request(urlString).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
                //if success
            case .success(let weatherResponse):
                self.cityName = weatherResponse.name
                self.temperature = String(format: "%.1f°C", weatherResponse.main.temp)
                self.weatherDescription = weatherResponse.weather.first?.description ?? ""
                
                // UI update
                DispatchQueue.main.async {
                    completion()
                }
                //
                
                //if error
            case .failure(let error):
                print("Ошибка при получении данных о погоде: \(error)")
            }
        }
    }//getWeather
}
