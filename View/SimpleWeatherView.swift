//SimpleWeatherView.swift
import UIKit


class SimpleWeatherView: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var viewModel = WeatherViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            cityNameLabel.isHidden = true
            tempLabel.isHidden = true
            weatherDescriptionLabel.isHidden = true
            
            loadingIndicator.startAnimating()

            // check, do we have a current location already
            if let location = DeviceLocationService.shared.currentLocation {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                print("Текущее местоположение: \(latitude), \(longitude)")
                
                // Получаем погоду для текущего местоположения
                viewModel.getWeather(latitude: latitude, longitude: longitude) {
                    self.updateWeatherUI()
                }
            } else {
                // if not, get current location
                DeviceLocationService.shared.startUpdatingLocationIfNeeded { location in
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    print("Обновлено местоположение: \(latitude), \(longitude)")
                    
                    // get weather for new location
                    self.viewModel.getWeather(latitude: latitude, longitude: longitude) {
                        self.updateWeatherUI()
                    }
                }
            }
        }
        
        // update UI
        private func updateWeatherUI() {
            self.cityNameLabel.text = self.viewModel.cityName
            self.tempLabel.text = self.viewModel.temperature
            self.weatherDescriptionLabel.text = self.viewModel.weatherDescription
            
            loadingIndicator.stopAnimating()
            
            cityNameLabel.isHidden = false
            tempLabel.isHidden = false
            weatherDescriptionLabel.isHidden = false
            loadingIndicator.isHidden = true
        }
    }

