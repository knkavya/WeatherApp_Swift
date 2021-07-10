//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Kavya KN on 10/07/21.
//

import SwiftUI


let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color.blue, Color.init(red: 173/255, green: 216/255, blue: 230/255)]),
    startPoint: .top, endPoint: .bottom)

struct WeatherView: View {
    
    @ObservedObject var viewModel : WeatherViewModel
    
    // MARK: UI Componets on the main screen.
    var body: some View {
        VStack(spacing: 20) {
            if (viewModel.cityName != "City Name"){
                Text(viewModel.cityName)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:2.0)))
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                Text(viewModel.temperature)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.5)))
                    .transition(.slide)
                    .font(.system(size: 70))
                Text(viewModel.weatherIcon)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.0)))
                    .transition(.slide)
                    .font(.largeTitle)
                    .padding()
                Text(viewModel.weatherDescription)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.5)))
                    .transition(.move(edge: .leading))
            }
        }.onAppear(perform: {
            viewModel.refresh()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .accentColor(Color.black)
        .background(backgroundGradient)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherForecastService: WeatherForecastService()))
    }
}
