//
//  PictureModel.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import ObjectMapper

struct PictureModel: Mappable {
    let large : URL?
    let medium : URL?
    let thumbnail : URL?
    
    init?(map: Map) {
        large = try? map.value("large", using: URLTransform())
        medium = try? map.value("medium", using: URLTransform())
        thumbnail = try? map.value("thumbnail", using: URLTransform())
    }
    
    func mapping(map: Map) {
        
    }
}
