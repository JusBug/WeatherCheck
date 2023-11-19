//
//  CollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/09.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var airStatusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    let dateManager = DateManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 20
    }
    
    func configureFont() {
        locationLabel.font = .preferredFont(forTextStyle: .title1)
        cityLabel.font = .preferredFont(forTextStyle: .body)
        airStatusLabel.font = .preferredFont(forTextStyle: .caption1)
        temperatureLabel.font = .preferredFont(forTextStyle: .title1)
        minMaxLabel.font = .preferredFont(forTextStyle: .caption1)
    }
    
    func configureLables(with weather: WeatherData, more daily: DailyWeather) {
        if let (location, city) = splitTimezone(timezone: weather.timezone) {
            locationLabel.text = "\(location)"
            cityLabel.text = "\(city)"
        }
        
        let time = dateManager.calculateTime(weather: weather)
        airStatusLabel.text = time
        temperatureLabel.text = "\(TemperatureConverter.kelvinToCelsius(weather.current.temp))º"
        minMaxLabel.text = "H:\(TemperatureConverter.kelvinToCelsius(daily.temp.min))º L:\(TemperatureConverter.kelvinToCelsius(daily.temp.max))º"
    }
    
    func setBackgroundImage(weather: WeatherData) {
        let time = dateManager.calculateTime(weather: weather)
        let backgroundImageName: String
        let components = time.split(separator: ":")
        
        if components.count == 2,
            let hour = Int(components[0]),
            let minute = Int(components[1]) {
            let currentMinutes = hour * 60 + minute

            if currentMinutes >= (6 * 60) && currentMinutes < (18 * 60) {
                backgroundImageName = "Sunny"
            } else {
                backgroundImageName = "Night"
            }
        } else {
            backgroundImageName = "Sunny"
        }

        let backgroundImageView = UIImageView(image: UIImage(named: backgroundImageName))
        backgroundImageView.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImageView, at: 0)
    }
    
    private func splitTimezone(timezone: String) -> (String, String)? {
        let lines = timezone.components(separatedBy: "/")
        if lines.count == 2{
            let location = lines[0]
            let city = lines[1]
            return (location, city)
        }
        
        return nil
    }
}
