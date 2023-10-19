//
//  TimeCollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/12/23.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 20
    }
    
    func configureFont() {
        timeLabel.font = .preferredFont(forTextStyle: .title1)
        temperatureLabel.font = .preferredFont(forTextStyle: .caption1)
    }
    
    func configureLables(with weather: WeatherData, more daily: DailyWeather) {
        timeLabel.text = "\(weather.current.temp)"
        temperatureLabel.text = "\(daily.temp.min) - \(daily.temp.max)"
    }
    
    func splitTimeLine(indexPath: IndexPath) {
        let time = (Calendar.current.component(.hour, from: Date()) + indexPath.item) % 24
        let timeString = (time == 0) ? "12" : (time <= 12) ? "\(time)" : "\(time - 12)"
        let ampm = (time < 12) ? "AM" : "PM"
        timeLabel.text = "\(timeString)\(ampm)"
    }
}
