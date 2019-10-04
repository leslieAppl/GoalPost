//
//  UIViewControllerExt.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewController: UIViewController) {
        guard let presentedVC = presentedViewController else { return }
        presentedVC.dismiss(animated: true) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
