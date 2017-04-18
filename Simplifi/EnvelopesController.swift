//
//  EnvelopesController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/31/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class EnvelopesController: UITableViewController {
    
    var envelopes = [UserEnvelopes]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var refresher: UIRefreshControl!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.78, blue: 0.33, alpha: 1)
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // set up the refresh control
        refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresher.addTarget(self, action: #selector(EnvelopesController.refreshData), for: .valueChanged)
        self.tableView?.addSubview(refresher)
        
        envelopeRouter.getEnvelopes(completion: { envelopes in
            self.envelopes = envelopes
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }
    
    func refreshData() {
        envelopeRouter.getEnvelopes(completion: { envelopes in
            self.envelopes = envelopes
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return envelopes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnvelopeCell", for: indexPath)
        var ratio = 0.0
        cell.textLabel?.text = envelopes[indexPath.row].name
        if envelopes[indexPath.row].amount != 0 {
            ratio = Double(envelopes[indexPath.row].envelopeAmountSpent) / Double(envelopes[indexPath.row].amount)
        }
        cell.detailTextLabel?.text = "\(envelopes[indexPath.row].envelopeAmountSpent)/\(envelopes[indexPath.row].amount)"
        if ratio > 1.0 || envelopes[indexPath.row].envelopeAmountSpent > envelopes[indexPath.row].amount {
            cell.detailTextLabel?.textColor = UIColor.red
        } else if ratio > 0.75 {
            cell.detailTextLabel?.textColor = UIColor.orange
        } else if ratio > 50 {
            cell.detailTextLabel?.textColor = UIColor.yellow
        } else {
            cell.detailTextLabel?.textColor = UIColor.init(red: 0.46, green: 0.79, blue: 0.04, alpha: 1)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVc = segue.destination as? EnvelopeDetailController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destVc.envelope = envelopes[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "envelopeDetailSegue", sender: indexPath)
    }

}
