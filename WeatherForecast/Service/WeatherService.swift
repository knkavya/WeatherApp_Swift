//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Kavya KN on 10/07/21.
//

import CoreLocation
import Foundation

public final class WeatherForecastService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_Key = "b2d02e8d496482f9b6a44c8fa9d324f7"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: Location update request.
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    // MARK: Request to open weather map using coordinates.
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_Key)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url){ data, responce, error in
            guard error == nil, let data = data else { return }
            if let responce = try? JSONDecoder().decode(APIResponce.self, from: data) {
                self.completionHandler?(Weather(responce: responce))
            }
        }.resume()
    }
}

// MARK: Location Manager Delegate.
extension WeatherForecastService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong : \(error.localizedDescription)")
    }
}

// MARK: JSON Responce Structure from the weather map API.
struct APIResponce : Decodable {
    let name: String
    let main : APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp : Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String

    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}

