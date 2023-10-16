//
//  TimeCollectionViewCell.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/12/23.
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
}
