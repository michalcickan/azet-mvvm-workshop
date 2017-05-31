//
//  UITableViewExtension.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellFromNib(_ nibName: String) -> String {
        let substringIndex = nibName.characters.index(nibName.startIndex, offsetBy: 1)
        
        let identifier = nibName.substring(to: substringIndex).lowercased() + nibName.substring(from: substringIndex)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
        
        return identifier
    }
}
