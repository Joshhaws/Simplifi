//
//  EnvelopesController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/31/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class EnvelopesController: UITableViewController {
    
    var envelopes = [Envelopes]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        envelopeRouter.getEnvelopes(completion: { envelopes in
            self.envelopes = envelopes
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return envelopes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnvelopeCell", for: indexPath)
        cell.textLabel?.text = envelopes[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVc = segue.destination as? EnvelopeDetailController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destVc.envelope = envelopes[indexPath.row]
            }
        }
        
        print(">>>>>>>>>>>>>>>>>Prepare for Segue")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "envelopeDetailSegue", sender: indexPath)
    }

}
