//
import CoreLocation

class DeviceLocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = DeviceLocationService()
    private let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    private var hasUpdatedLocation = false // the flag for checking repeated calls
    private var locationUpdateHandler: ((CLLocation) -> Void)? // handler for updating current location
    private var errorHandler: ((Error?) -> Void)? // errors handler
        
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func startUpdatingLocationIfNeeded(completion: @escaping (CLLocation) -> Void) {
        if let location = currentLocation {
            completion(location)
        } else {
            locationUpdateHandler = completion
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !hasUpdatedLocation, let location = locations.last {
            currentLocation = location
            hasUpdatedLocation = true
            locationManager.stopUpdatingLocation()
            
            locationUpdateHandler?(location)
            locationUpdateHandler = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if locationManager.authorizationStatus == .denied {
            errorHandler?(nil)
            print("Доступ к местоположению был запрещен. Пожалуйста, разрешите доступ в настройках.")
        }
//        else {
//            print("Error occurs: \(error.localizedDescription)")
//        }
    }
    
    
    
}
