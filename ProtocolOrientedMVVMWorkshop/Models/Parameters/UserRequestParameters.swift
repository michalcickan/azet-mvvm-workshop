//
//  UserListParams.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import ObjectMapper

class UserRequestParameters : JSONValue {
    var page : Int
    var perPage : Int
    
    init(page: Int = 1, perPage: Int = 40) {
        self.page = page
        self.perPage = perPage
    }
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        perPage <- map["results"]
    }
}
