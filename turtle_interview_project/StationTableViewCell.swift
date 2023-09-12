//
//  StationTableViewCell.swift
//  turtle_interview_project
//
//  Created by Stephen on 2023/9/12.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countiesLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
