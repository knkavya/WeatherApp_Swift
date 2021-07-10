//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Kavya KN on 10/07/21.
//

import Foundation

private let defaultWeatherForecastIcon = "?"
private let weatherForecastIcons = [
    "Drizzel" : "🌧",
    "ThunderStorm" : "⛈",
    "Rain" : "🌧",
    "Snow" : "🌨",
    "Clear" : "☀️",
    "Clouds" : "☁️"
]

// MARK: Getting data from serive and converting the model to the information that our view needs to display in view.
public class WeatherViewModel : ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultWeatherForecastIcon

    public let weatherForecastService: WeatherForecastService
    
    public init(weatherForecastService: WeatherForecastService){
        self.weatherForecastService = weatherForecastService
    }
    
    // MARK: Calling weather serive method to load the weather data.On getting data view model will update the UI data.
    public func refresh() {
        weatherForecastService.loadWeatherData{ weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature =  "\(weather.temperature)ºC"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = weatherForecastIcons[weather.iconName] ?? defaultWeatherForecastIcon
            }
        }
    }
}
