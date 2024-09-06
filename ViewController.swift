
//  ViewController.swift

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getWeather(for: "Kursk") {
            self.cityNameLabel.text = self.viewModel.cityName
            self.tempLabel.text = self.viewModel.temperature
            self.descriptionLabel.text = self.viewModel.weatherDescription
        }
        
    }


}

