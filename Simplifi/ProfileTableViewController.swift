//
//  ProfileTableViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import UIKit
import LinkKit

class ProfileTableViewController : UITableViewController {
    
    var userInformation: [String] = []
    var accounts: [Account] = []
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.78, blue: 0.33, alpha: 1)
//        self.navigationController?.navigationBar.titleTextAttributes. = UIColor.white
        
        refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresher.addTarget(self, action: #selector(ProfileTableViewController.refreshData), for: .valueChanged)
        self.tableView?.addSubview(refresher)
        
        userInformation.append("\(UserDefaults.standard.string(forKey: "user_firstName")!) \(UserDefaults.standard.string(forKey: "user_lastName")!)")
        userInformation.append(UserDefaults.standard.string(forKey: "user_email")!)
        userInformation.append("Logout")
        
        accountRouter.getAccounts(completion: {accounts in
            self.accounts = accounts
            self.tableView.reloadData()
            })
    }
    
    func refreshData() {
        accountRouter.getAccounts(completion: {accounts in
            self.accounts = accounts
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
            header = "User Profile"
        } else if section == 1 {
            header = "Accounts"
        } else {
            header = ""
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = userInformation.count
        } else if section == 1 {
            rowCount = accounts.count
        } else {
            rowCount = 1
        }
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = userInformation[indexPath.row]
            cell.detailTextLabel?.text = ""
        } else if indexPath.section == 1 {
            cell.textLabel?.text = accounts[indexPath.row].name
            cell.detailTextLabel?.text = accounts[indexPath.row].institutionName
        } else {
            cell.textLabel?.text = "Add Account"
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 3 {
            //perform logout
        } else if indexPath.section == 2 {
            presentPlaidLinkWithCustomConfiguration()
        } else if indexPath.section == 0 && indexPath.row == 2 {
            if let app = UIApplication.shared.delegate as? AppDelegate{
                let title = ""
                let message = "Are you sure you want to logout?"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive, handler: { alertAction in
                    logoutRouter.logout(completion: { success in})
                    app.showLoginScreen()
                })
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(action)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //Mark - PlaidAPI stuff
    
    
    func didReceiveNotification(_ notification: Notification) {
        if notification.name.rawValue == "PLDPlaidLinkSetupFinished" {
            NotificationCenter.default.removeObserver(self, name: notification.name, object: nil)
        }
    }
    
    func handleSuccessWithToken(_ publicToken: String, metadata: [String : AnyObject]?) {
        //        accessTokenRouter.updloadAccessToken(token: publicToken, completion: <#T##(Bool) -> Void#>)
        accessTokenRouter.updloadAccessToken(token: publicToken, completion: {success in
            self.refreshData()
        })
//        presentAlertViewWithTitle("Success", message: "token: \(publicToken)\nmetadata: \(metadata!)")
        presentAlertViewWithTitle("Success", message: "You've succesfully added an account")
    }
    
    func handleError(_ error: NSError, metadata: [String : AnyObject]?) {
        presentAlertViewWithTitle("Failure", message: "There was a problem adding the account")
//        presentAlertViewWithTitle("Failure", message: "error: \(error.localizedDescription)\nmetadata: \(metadata!)")
    }
    
    func handleExitWithMetadata(_ metadata: [String : AnyObject]?) {
//        presentAlertViewWithTitle("Exit", message: "metadata: \(metadata!)")
    }
    
    func presentAlertViewWithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Plaid Link setup with custom configuration
    func presentPlaidLinkWithCustomConfiguration() {
        // With custom configuration
        let linkConfiguration = PLKConfiguration(key: SyncHelper.Constants.plaidApiKey, env: .sandbox, product: .auth, selectAccount: false, longtailAuth: false, apiVersion: .PLKAPIv2)
        linkConfiguration.clientName = "SimpliFi"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true, completion: nil)
    }
}



extension ProfileTableViewController : PLKPlaidLinkViewDelegate {
    
    func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [String : Any]?) {
        dismiss(animated: true) {
            // Handle success, e.g. by storing publicToken with your service
            NSLog("Successfully linked account!\npublicToken: \(publicToken)\nmetadata: \(String(describing: metadata))")
            self.handleSuccessWithToken(publicToken, metadata: metadata as [String : AnyObject]?)
        }
    }
    
    func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
        dismiss(animated: true) {
            if let error = error {
                NSLog("Failed to link account due to: \(error.localizedDescription)\nmetadata: \(String(describing: metadata))")
                self.handleError(error as NSError, metadata: metadata as [String : AnyObject]?)
            }
            else {
                NSLog("Plaid link exited with metadata: \(String(describing: metadata))")
                self.handleExitWithMetadata(metadata as [String : AnyObject]?)
            }
        }
    }
}
