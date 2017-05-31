//
//  FirstViewController.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    fileprivate var userCellIdentifier = ""
    var datasource: UsersDatasourceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCellIdentifier = self.tableView.registerCellFromNib(UserDetailTableViewCell.name)
        
        self.registerTableDelegates()
        self.tableView.estimatedRowHeight = 44
        
        datasource?.fetchUsers(completionHandler: { success in
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func registerTableDelegates() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension UsersViewController: UITableViewDelegate {
    
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.userViewModels.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as! UserDetailTableViewCell
        
        cell.configure(datasource: datasource!.userViewModels[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

