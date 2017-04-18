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
    
    
    var envelope = UserEnvelopes()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.78, blue: 0.33, alpha: 1)
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
    
    @IBAction func categoryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "editEnvelopeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? EditEnvelopeViewController {
            destVC.envelope = envelope
        }
        if let detailVC = segue.destination as? TransactionDetailViewController {
            if let indexPath = envelopeDetailTable.indexPathForSelectedRow {
                detailVC.transaction = envelope.userEnvelopeTransactions[indexPath.row]
            }
        }
    }
    
    private func setRatioBar() {
        envelopeRatioLabel.text = "\(envelope.envelopeAmountSpent)/\(envelope.amount)"
        //get total budget width
        let budgetWidth = overallBudget.frame.size.width
        //get ratio
        var ratio: CGFloat = 0.0
        
        if envelope.amount != 0 {
            ratio = CGFloat(envelope.envelopeAmountSpent)/CGFloat(envelope.amount)
        }
        
        if ratio >= 1.0 {
            let inverseRatio = 1.0/ratio
            overallBudget.backgroundColor = UIColor.red
            totalSpentBar.frame.size.width = budgetWidth * (inverseRatio)
        } else {
            totalSpentBar.frame.size.width = budgetWidth * ratio
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Transactions in \(envelope.name)"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return envelope.userEnvelopeTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = envelopeDetailTable.dequeueReusableCell(withIdentifier: "envelopeTransactionCell", for: indexPath)
        if envelope.userEnvelopeTransactions[indexPath.row].storeName == "" {
            cell.textLabel?.text = "Store Name Unavailable"
        } else{
            cell.textLabel?.text = envelope.userEnvelopeTransactions[indexPath.row].storeName
        }
        cell.detailTextLabel?.text = "$\(envelope.userEnvelopeTransactions[indexPath.row].amount)"
        return cell
    }
    
    
//    transactionDetailSegue
    
    func setupProgressBars() {
        self.overallBudget.layer.cornerRadius = 2.0
        self.totalSpentBar.layer.cornerRadius = 2.0
        self.envelopeView.layer.cornerRadius = 2.0
    }
    
}
