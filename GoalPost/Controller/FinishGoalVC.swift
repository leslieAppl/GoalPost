//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    
    var goalDescription: String?
    var goalType: GoalType?
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
        
        
        
    }
    
    @IBAction func createGoalBtn(_ sender: Any) {
        // Pass data into Core Data Model
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pointsTextField.text = ""
        
    }
    
}
