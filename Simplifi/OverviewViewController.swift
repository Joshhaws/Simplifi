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
    @IBOutlet weak var budgetView: UIView!
    
    //testVariables
    var totalBudget = 0
    var spentBudget = 0
    var envelopes = [EnvelopeBasic]()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.78, blue: 0.33, alpha: 1)
        super.viewDidLoad()
        UserDefaults.standard.synchronize()
        
        if ((UserDefaults.standard.value(forKey: "user_auth_token") != nil)) {
            envelopeRouter.getEnvelopeBasic(completion: { envelopes in
                self.envelopes = envelopes
                self.updateChartWithData()
                self.setupChartView()
            })
            usersRouter.getUsersWithID(completion: { user in
                self.totalBudget = user.overallBudget
                self.spentBudget = user.overallSpent
                self.setupBudgetBox()
            })
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupBudgetBox()
        self.setupChartView()
    }
    
    override func viewDidLayoutSubviews() {
        setupBudgetBox()
    }
    
    func setupBudgetBox() {
        ratioLabel.text = "\(spentBudget)/\(totalBudget)"
        //get total budget width
        let budgetWidth = overallBudgetBar.frame.size.width
        //get ratio
        var ratio : CGFloat = 0.0
        if totalBudget != 0 {
            ratio = CGFloat(spentBudget)/CGFloat(totalBudget)
        }
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
        self.budgetView.layer.cornerRadius = 2.0
        self.barView.layer.cornerRadius = 2.0
    }
    
    func setupChartView() {
        barView.chartDescription?.enabled = false
        barView.pinchZoomEnabled = false
        barView.drawBarShadowEnabled = false
        barView.drawGridBackgroundEnabled = false
        barView.xAxis.drawGridLinesEnabled = false
        barView.leftAxis.drawGridLinesEnabled = false
        barView.rightAxis.drawGridLinesEnabled = false
        barView.xAxis.drawLabelsEnabled = false
        barView.rightAxis.drawLabelsEnabled = false
        barView.legend.enabled = false
        barView.rightAxis.enabled = false
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.enabled = false
        barView.leftAxis.enabled = false
        barView.drawValueAboveBarEnabled = true
        barView.xAxis.granularity = 1
        barView.minOffset = 5
        barView.drawMarkers = true
        barView.pinchZoomEnabled = false
        barView.doubleTapToZoomEnabled = false
        barView.leftAxis.labelPosition = .insideChart
    }
    
    
    func updateChartWithData() {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<envelopes.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(envelopes[i].amount)!, data: envelopes[i].name as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Envelopes")
        chartDataSet.colors = ChartColorTemplates.material()
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        let marker = BalloonMarker(color: UIColor.clear, font: UIFont.systemFont(ofSize: 15.0), textColor: UIColor.black, insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
    
        barView.data = chartData
        barView.marker = marker
        barView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
}
