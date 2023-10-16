//
//  DayCollectionViewCell.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/16/23.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
        // Initialization code
    }

    private func configureLayer() {
        layer.cornerRadius = 20
    }
}
