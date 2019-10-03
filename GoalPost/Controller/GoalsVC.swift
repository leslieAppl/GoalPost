//
//  ViewController.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if goals.count > 0 {
            tableView.isHidden = false
            
        }
        
        // test lines
//        tableView.isHidden = false
//        let goal = GoalTest()
//        goal.goalDesc = "Eat Apple every day"
//        goal.goalType = GoalType.longTerm.rawValue
//        goal.goalProgress = Int32(10)
//
//        self.goals.append(goal)
    }

    @IBAction func addGoalBtn(_ sender: Any) {
        
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell()}
        cell.configureCell(goal: goals[indexPath.row])
        return cell
    }
}
