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
    @IBOutlet weak var completiongView: UIView!
    
    func configureCell(goal: Goal) {
        self.goalDescLbe.text = goal.goalDesc
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
            
        if goal.goalProgress == 0 {
            self.completiongView.isHidden = false
        } else {
            self.completiongView.isHidden = true
        }
    }
    
}
