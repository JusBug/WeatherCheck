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
    
    func configureLables(with weather: WeatherData) {
        locationLabel.text = "\(weather.timezone)"
        cityLabel.text = "\(weather.timezone)"
        airStatusLabel.text = "\(weather.current.visibility)"
        temperatureLabel.text = "\(weather.current.temp)"
        minMaxLabel.text = "\(weather.timezone)"
    }
}
