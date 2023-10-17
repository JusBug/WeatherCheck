//
//  TableViewCell.swift
//  WeatherCheck
//
//  Created by 박종화 on 10/18/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
