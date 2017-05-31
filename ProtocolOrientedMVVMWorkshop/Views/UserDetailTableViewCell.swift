//
//  UserDetailTableViewCell.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import UIKit
import Alamofire

protocol UserDetailCellDatasource {
    var profileImageUrl: URL? { get }
    var nick: String { get }
    var description: String { get }
}

class UserDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(datasource: UserDetailCellDatasource) {
        self.nickLabel.text = datasource.nick
        self.descriptionLabel.text = datasource.description
    }
}

