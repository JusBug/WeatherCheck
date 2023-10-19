//
//  moreInfoCollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/16/23.
//

import UIKit

class moreInfoCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
        self.alpha = 0.2
    }

    private func configureLayer() {
        layer.cornerRadius = 20
    }
}
