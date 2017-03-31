//
//  OverviewViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit
import Charts

class OverviewViewController : UIViewController {
    
    @IBOutlet weak var spentTotalBar: UIView!
    @IBOutlet weak var overallBudgetBar: UIView!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var barView: BarChartView!
    
    //testVariables
    var totalBudget = 750
    var spentBudget = 600
    var envelopes = [Envelopes]()
    var envelopeNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBudgetBox()
        
        if ((UserDefaults.standard.value(forKey: "user_auth_token") != nil)) {
            envelopeRouter.getEnvelopes(completion: { envelopes in
                self.envelopes = envelopes
                self.updateChartWithData()
                self.setupChartView()
            })
        }
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
        setupProgressBars()
    }
    
    func setupProgressBars() {
        self.overallBudgetBar.layer.cornerRadius = 2.0
        self.spentTotalBar.layer.cornerRadius = 2.0
    }
    
    func setupChartView() {
        barView.chartDescription?.enabled = false
        barView.pinchZoomEnabled = false
        barView.drawBarShadowEnabled = false
        barView.drawGridBackgroundEnabled = false
        barView.xAxis.drawGridLinesEnabled = false
        barView.leftAxis.drawGridLinesEnabled = false
        barView.rightAxis.drawGridLinesEnabled = false
        barView.xAxis.drawLabelsEnabled = true
        barView.rightAxis.drawLabelsEnabled = false
        barView.legend.enabled = false
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.granularity = 1
    }
    
    
    func updateChartWithData() {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<envelopes.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(envelopes[i].amount))
            dataEntries.append(dataEntry)
            envelopeNames.append(envelopes[i].name)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Envelopes")
        chartDataSet.colors = ChartColorTemplates.material()
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        barView.data = chartData
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values:envelopeNames)
    }
    
}
