//
//  CategoriesViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UITableViewController {
    
    var categories = [Category]()
    var envelopeCount = 2
    var envelopeId = 100
    var envelopeCategories: [Category] = []
    var nonEnvelopeCategories: [Category] = []
    var envelopeHeader = "Donations"
    
    override func viewDidLoad() {
        categoriesRouter.getCategories(completion: {categories in
            for i in 0..<categories.count {
                if categories[i].envelope.id == self.envelopeId {
                    self.envelopeCategories.append(categories[i])
                } else {
                    self.nonEnvelopeCategories.append(categories[i])
                }
            }
            self.categories = categories
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return envelopeCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
            header = "Categories Associated With \(envelopeHeader)"
        } else {
            header = "Other Categories"
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        if indexPath.section == 0 {
            if envelopeCategories[indexPath.row].hierarchy_3 != "" && envelopeCategories[indexPath.row].hierarchy_3 != "Null" {
                cell.textLabel?.text = envelopeCategories[indexPath.row].hierarchy_3
            } else if envelopeCategories[indexPath.row].hierarchy_2 != "" && envelopeCategories[indexPath.row].hierarchy_2 != "Null" {
                cell.textLabel?.text = envelopeCategories[indexPath.row].hierarchy_2
            } else {
                cell.textLabel?.text = envelopeCategories[indexPath.row].hierarchy_1
            }
            cell.detailTextLabel?.text = envelopeCategories[indexPath.row].envelope.name
            
        } else {
            if nonEnvelopeCategories[indexPath.row].hierarchy_3 != "" && nonEnvelopeCategories[indexPath.row].hierarchy_3 != "Null" {
                cell.textLabel?.text = nonEnvelopeCategories[indexPath.row].hierarchy_3
            } else if nonEnvelopeCategories[indexPath.row].hierarchy_2 != "" && nonEnvelopeCategories[indexPath.row].hierarchy_2 != "Null" {
                cell.textLabel?.text = nonEnvelopeCategories[indexPath.row].hierarchy_2
            } else {
                cell.textLabel?.text = nonEnvelopeCategories[indexPath.row].hierarchy_1
            }
            cell.detailTextLabel?.text = nonEnvelopeCategories[indexPath.row].envelope.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = envelopeCategories.count
        } else {
            rowCount = nonEnvelopeCategories.count
        }
        return rowCount
    }

    
}
