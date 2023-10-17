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
    
    func configureLables(with weather: WeatherData) {
        if let (location, city) = splitTimezone(timezone: weather.timezone) {
            locationLabel.text = "\(location)"
            cityLabel.text = "\(city)"
        }
        airStatusLabel.text = "\(weather.current.visibility)"
        temperatureLabel.text = "\(weather.current.temp)"
        minMaxLabel.text = "\(weather.timezone)"
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
