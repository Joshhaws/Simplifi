//
//  EnvelopeDetailController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/31/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class EnvelopeDetailController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var envelopeNameLabel: UILabel!
    @IBOutlet weak var envelopeRatioLabel: UILabel!
    @IBOutlet weak var envelopeDetailTable: UITableView!
//    @IBOutlet weak var totalSpentBar: UIView!
//    @IBOutlet weak var overallBudget: UIView!
    @IBOutlet weak var overallBudget: UIView!
    @IBOutlet weak var totalSpentBar: UIView!
    @IBOutlet weak var envelopeView: UIView!
    
    
    var envelope = Envelopes()
    
    override func viewDidLoad() {
        self.title = envelope.name
        envelopeNameLabel.text = envelope.name
        setRatioBar()
        setupProgressBars()
        
        self.envelopeDetailTable.dataSource = self
        
        self.envelopeDetailTable.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        setRatioBar()
    }
    
    private func setRatioBar() {
        envelopeRatioLabel.text = "\(envelope.totalSpentEnvelope)/\(envelope.amount)"
        //get total budget width
        let budgetWidth = overallBudget.frame.size.width
        //get ratio
        let ratio = CGFloat(envelope.totalSpentEnvelope)/CGFloat(envelope.amount)
        
        if ratio >= 1.0 {
            let inverseRatio = 1.0/ratio
            overallBudget.backgroundColor = UIColor.red
            totalSpentBar.frame.size.width = budgetWidth * (inverseRatio)
        } else {
            totalSpentBar.frame.size.width = budgetWidth * ratio
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return envelope.accountTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = envelopeDetailTable.dequeueReusableCell(withIdentifier: "envelopeTransactionCell", for: indexPath)
        if envelope.accountTransactions[indexPath.row].storeName == "" {
            cell.textLabel?.text = envelope.accountTransactions[indexPath.row].testAccountName
        } else{
            cell.textLabel?.text = envelope.accountTransactions[indexPath.row].storeName
        }
        cell.detailTextLabel?.text = "$\(envelope.accountTransactions[indexPath.row].amount)"
        return cell
    }
    
    func setupProgressBars() {
        self.overallBudget.layer.cornerRadius = 2.0
        self.totalSpentBar.layer.cornerRadius = 2.0
        self.envelopeView.layer.cornerRadius = 2.0
    }
    
}
