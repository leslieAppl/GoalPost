//
//  GoalCell.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescLbe: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: GoalType, goalProgressAmount: Int) {
        self.goalDescLbe.text = description
        self.goalTypeLbl.text = ""
        self.goalProgressLbl.text = String(describing: goalProgressAmount)
    }
    
}
