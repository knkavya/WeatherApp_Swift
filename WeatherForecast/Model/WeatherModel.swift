//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by Kavya KN on 10/07/21.
//

import Foundation

// MARK: Model data which our ViewModel will use.
public struct Weather {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(responce: APIResponce){
        city = responce.name
        temperature = "\(Int(responce.main.temp))"
        description = responce.weather.first?.description ?? ""
        iconName = responce.weather.first?.iconName ?? ""
    }
}
