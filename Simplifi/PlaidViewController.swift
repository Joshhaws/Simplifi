//
//  PlaidViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/29/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import LinkKit

class PlaidViewController : ViewController {
    
    @IBOutlet var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(PlaidViewController.didReceiveNotification(_:)), name: NSNotification.Name(rawValue: "PLDPlaidLinkSetupFinished"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let linkKitBundle  = Bundle(for: PLKPlaidLinkViewController.self)
//        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
//        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String)!
//        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String)!x
    }

    
    @IBAction func buttonPressed(_ sender: Any) {
        presentPlaidLinkWithCustomConfiguration()
    }
    
    
    func didReceiveNotification(_ notification: Notification) {
        if notification.name.rawValue == "PLDPlaidLinkSetupFinished" {
            NotificationCenter.default.removeObserver(self, name: notification.name, object: nil)
//            button.isEnabled = true
        }
    }

    func handleSuccessWithToken(_ publicToken: String, metadata: [String : AnyObject]?) {
//        accessTokenRouter.updloadAccessToken(token: publicToken, completion: <#T##(Bool) -> Void#>)
        presentAlertViewWithTitle("Success", message: "token: \(publicToken)\nmetadata: \(metadata!)")
    }
    
    func handleError(_ error: NSError, metadata: [String : AnyObject]?) {
        presentAlertViewWithTitle("Failure", message: "error: \(error.localizedDescription)\nmetadata: \(metadata!)")
    }
    
    func handleExitWithMetadata(_ metadata: [String : AnyObject]?) {
        presentAlertViewWithTitle("Exit", message: "metadata: \(metadata!)")
    }
    
    func presentAlertViewWithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Plaid Link setup with shared configuration from Info.plist
    func presentPlaidLinkWithSharedConfiguration() {
        // With shared configuration from Info.plist
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true, completion: nil)
    }
    
    func presentPlaidFromClass() -> PLKPlaidLinkViewController {
        // With custom configuration9
        let linkConfiguration = PLKConfiguration(key: SyncHelper.Constants.plaidApiKey, env: .sandbox, product: .auth, selectAccount: false, longtailAuth: false, apiVersion: .PLKAPIv2)
        linkConfiguration.clientName = "SimpliFi"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        return linkViewController
    }
    
    // MARK: Plaid Link setup with custom configuration
    func presentPlaidLinkWithCustomConfiguration() {
        // With custom configuration9
        let linkConfiguration = PLKConfiguration(key: SyncHelper.Constants.plaidApiKey, env: .sandbox, product: .auth, selectAccount: false, longtailAuth: false, apiVersion: .PLKAPIv2)
        linkConfiguration.clientName = "SimpliFi"
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true, completion: nil)
    }
    
    // MARK: Start Plaid Link with an institution pre-selected
    func presentPlaidLinkWithCustomInitializer() {
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(institution: "<#INSTITUTION_ID#>", delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet;
        }
        present(linkViewController, animated: true, completion: nil)
    }
    
    // MARK: Start Plaid Link in update mode
    func presentPlaidLinkInUpdateMode() {
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(publicToken: "<#GENERATED_PUBLIC_TOKEN#>", delegate: linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet
        }
        present(linkViewController, animated: true, completion: nil)
    }
}

extension PlaidViewController : PLKPlaidLinkViewDelegate {
    
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




