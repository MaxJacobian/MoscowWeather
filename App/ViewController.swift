//
//  ViewController.swift
//  App
//
//  Created by Максим Нечеперунко on 13.10.2020.
//

import UIKit

import Alamofire


class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var feelsLike: UILabel!
    
    @IBOutlet weak var speedWind: UILabel!
    
    @IBOutlet weak var mainDescription: UILabel!
    
    @IBOutlet weak var supportDescription: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    
    var forecastData: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = LoaderWeather()
        loader.delegate = self
        loader.loaderWeather()
        
        let load = LoaderForecast()
        load.delegate = self
        load.loaderForecast()

        
    }
}
extension ViewController: LoaderWeatherDelegate{
    func loaderWeatherDelegate(welcom: Welcome) {
        temperature.text = "\(round(welcom.main.temp - 273.5)) °C"
        feelsLike.text = "feels like: \(round(welcom.main.feelsLike - 273.5)) °C"
        speedWind.text = "speed wind: \(welcom.wind.speed)m/s"
        mainDescription.text = "Main: \(welcom.weather[0].main)"
        supportDescription.text = "Description: \(welcom.weather[0].weatherDescription)"
        cityName.text = "\(welcom.name)"
    }
    
    
}
extension ViewController: LoaderForecastDelegate {
    func forecastDelegate(forecast: Forecast) {
        self.forecastData = forecast
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
}


extension ViewController: UITableViewDataSource {
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData?.list.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forecast") as! ForecastTableViewCell
        cell.dateLabel.text = "\( forecastData?.list[indexPath.row].dtTxt ?? "")"
        let temp = forecastData?.list[indexPath.row].main.temp ?? 1
        cell.temperatureLabel.text = "\(round(temp - 273.15)) °C"
        return cell
    }
    
    
}




