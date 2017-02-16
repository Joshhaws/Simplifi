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
    var spentBudget = 100
    
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
        //set width
//        spentTotalBar.frame = UIBezierPath(rect: CGRect(x:0, y:0, width:budgetWidth * ratio, height:self.spentTotalBar.frame.height))

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        print(budgetWidth)
        print(budgetWidth * ratio)
        spentTotalBar.frame.size.width = budgetWidth * ratio
        
    }
}
