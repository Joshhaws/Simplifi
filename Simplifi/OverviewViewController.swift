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
    var spentBudget = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
        spentTotalBar.frame.size.width = budgetWidth * ratio
        
    }
}
