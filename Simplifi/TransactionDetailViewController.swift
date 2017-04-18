//
//  TransactionDetailViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/11/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import UIKit

class TransactionDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var transaction = Transactions()
    var categories = [Category]()
    var categoryId = 0
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var valuePicker: UIPickerView!
    
    override func viewDidLoad() {
        storeNameLabel.text = transaction.storeName
        dateLabel.text = transaction.date
        amountLabel.text = String(transaction.amount)
        valuePicker.dataSource = self
        valuePicker.delegate = self
        
        categoriesRouter.getCategories(completion: {categories in
            self.categories = categories
            var row = 0
            for i in categories {
                if i.categoryId == self.transaction.categoryId {
                    break
                }
                row += 1
            }
            self.valuePicker.reloadAllComponents()
            self.valuePicker.selectRow(row, inComponent: 0, animated: false)
        })
    }
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        
        if categories[row].hierarchy_3 != "" && categories[row].hierarchy_3 != "Null" {
            title = categories[row].hierarchy_3
        } else if categories[row].hierarchy_2 != "" && categories[row].hierarchy_2 != "Null" {
            title = categories[row].hierarchy_2
        } else {
            title = categories[row].hierarchy_1
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryId = categories[row].categoryId
    }
    
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        accountTransactions.setCategoryForTransaction(categoryId: categoryId, transactionId: transaction.transactionId, completion: { success in
            if (success) {
                let title = "Success"
                let message = "You have updated your account transaction"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                let title = "Failure"
                let message = "An error has occured. Please try again"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
    }
    
    
}
