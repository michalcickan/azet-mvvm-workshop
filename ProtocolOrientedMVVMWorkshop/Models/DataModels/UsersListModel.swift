//
//  UsersListModel.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserListModel: Mappable {
    var users: [UserModel]?
    //var info: [InfoModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        users <- map["results"]
    }
}
