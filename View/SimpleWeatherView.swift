//SimpleWeatherView.swift
import UIKit
import Combine

class SimpleWeatherView: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getWeather(for: "Kursk") {
            self.cityNameLabel.text = self.viewModel.cityName
            self.tempLabel.text = self.viewModel.temperature
            self.weatherDescriptionLabel.text = self.viewModel.weatherDescription
        }
        
    }
    
    
}

