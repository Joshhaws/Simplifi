//
//  EditEnvelopeViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/11/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import UIKit

class EditEnvelopeViewController : UIViewController {
    
    
    var envelope = UserEnvelopes()
    
    @IBOutlet weak var envelopeNameLabel: UILabel!
    @IBOutlet weak var envelopeAmountSlider: UISlider!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var envelopeAmountLabel: UILabel!
    
    
    override func viewDidLoad() {
        envelopeNameLabel.text = "\(envelope.name)"
        envelopeAmountLabel.text = "Envelope Limit: \(envelope.amount)"
        envelopeAmountSlider.value = Float(envelope.amount)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        envelopeAmountLabel.text = "Envelope Limit: \(Int(sender.value))"
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("button pressed")
        envelopeRouter.setEnvelopeAmount(amount: Int(envelopeAmountSlider.value), envelopeId: envelope.envelopeId, completion: { success in
            if (success) {
                let title = "Success"
                let message = "You have updated your envelope amount"
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
