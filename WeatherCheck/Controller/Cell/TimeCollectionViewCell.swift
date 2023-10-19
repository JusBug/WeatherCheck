//
//  TimeCollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/12/23.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFont()
    }
    
    func configureFont() {
        timeLabel.font = .preferredFont(forTextStyle: .title3)
        weatherLabel.font = .preferredFont(forTextStyle: .title2)
        temperatureLabel.font = .preferredFont(forTextStyle: .title3)
    }
    
    func configureLables() {
        weatherLabel.text = "🌤️"
        temperatureLabel.text = "20"
    }
    
    func splitTimeLine(indexPath: IndexPath) {
        let time = (Calendar.current.component(.hour, from: Date()) + indexPath.item) % 24
        let timeString = (time == 0) ? "12" : (time <= 12) ? "\(time)" : "\(time - 12)"
        let ampm = (time < 12) ? "AM" : "PM"
        timeLabel.text = "\(timeString)\(ampm)"
    }
}
