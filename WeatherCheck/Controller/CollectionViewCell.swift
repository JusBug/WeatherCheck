//
//  CollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/09.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 20
    }
}
