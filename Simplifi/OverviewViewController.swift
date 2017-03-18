//
//  OverviewViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class OverviewViewController : UIViewController {
    
    @IBOutlet weak var spentTotalBar: UIView!
    @IBOutlet weak var overallBudgetBar: UIView!
    @IBOutlet weak var ratioLabel: UILabel!
    
    //testVariables
    var totalBudget = 750
    var spentBudget = 800
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBudgetBox()
        setupProgressBars()
    }
    
    override func viewDidLayoutSubviews() {
        setupBudgetBox()
    }
    
    func setupBudgetBox() {
        ratioLabel.text = "\(spentBudget)/\(totalBudget)"
        
        //get total budget width
        let budgetWidth = overallBudgetBar.frame.size.width
        //get ratio
        let ratio : CGFloat = CGFloat(spentBudget)/CGFloat(totalBudget)
        if ratio >= 1.0 {
            let inverseRatio = 1.0/ratio
            overallBudgetBar.backgroundColor = UIColor.red
            spentTotalBar.frame.size.width = budgetWidth * (inverseRatio)
        } else {
            spentTotalBar.frame.size.width = budgetWidth * ratio
        }
    }
    
    func setupProgressBars() {
        self.overallBudgetBar.layer.cornerRadius = 2.0
        self.spentTotalBar.layer.cornerRadius = 2.0
    }
}
