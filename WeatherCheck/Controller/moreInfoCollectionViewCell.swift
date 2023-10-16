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
    }

    private func configureLayer() {
        layer.cornerRadius = 20
    }
}
