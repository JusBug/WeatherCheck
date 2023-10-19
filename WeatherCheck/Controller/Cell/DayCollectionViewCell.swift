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
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFont()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor(white: 1.0, alpha: 0.5).cgColor)
        context?.setLineWidth(1)
        context?.move(to: CGPoint(x: 0, y: rect.size.height))
        context?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        context?.strokePath()
    }
    
    func configureFont() {
        dayLabel.font = .preferredFont(forTextStyle: .title3)
        weatherLabel.font = .preferredFont(forTextStyle: .title2)
        lowTemp.font = .preferredFont(forTextStyle: .caption1)
        highTemp.font = .preferredFont(forTextStyle: .caption1)
    }
    
    func configureLables() {
        weatherLabel.text = "🌤️"
        lowTemp.text = "10"
        highTemp.text = "20"
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
