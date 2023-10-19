//
//  DayCollectionViewCell.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/16/23.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayer()
        configureFont()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 10
    }
    
    func configureFont() {
        dayLabel.font = .preferredFont(forTextStyle: .title3)
        lowTemp.font = .preferredFont(forTextStyle: .caption1)
        highTemp.font = .preferredFont(forTextStyle: .caption1)
    }
    
    func configureCell(indexPath: IndexPath) {
        let today = Date()
        let calendar = Calendar.current
        if let dateForCell = calendar.date(byAdding: .day, value: indexPath.item, to: today) {
            dayLabel.text = getDayOfWeek(date: dateForCell)
        }
    }
    
    func getDayOfWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // 요일을 영어로 표시
        return dateFormatter.string(from: date)
    }
}
