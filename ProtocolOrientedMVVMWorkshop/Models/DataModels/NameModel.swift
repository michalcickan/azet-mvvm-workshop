//
//  NameModel.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import ObjectMapper

struct NameModel: Mappable {
    let title: String?
    let name: String?
    let surname: String?
    
    init?(map: Map) {
        title = map["title"].value()
        name = map["first"].value()
        surname = map["last"].value()
    }
    
    func mapping(map: Map) {
        
    }
}
