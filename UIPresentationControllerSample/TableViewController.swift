//
//  TableViewController.swift
//  UIPresentationControllerSample
//
//  Created by K.Kawakami on 2016/11/06.
//  Copyright © 2016年 川上健太郎. All rights reserved.
//

import UIKit

protocol TableViewControllerDelegate {
    func didSelectCell()
}

class TableViewController: UITableViewController {
    
    var delegates: TableViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion:  {
            self.delegates?.didSelectCell()
        })
    }
}
