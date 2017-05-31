//
//  RealmUserModel.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserModel: Object, NSCopying  {
    dynamic var gender: String?
    dynamic var email : String?
    dynamic var phone : String?
    dynamic var  nationality: String?
    dynamic var  pictureModel : RealmPictureModel?
    dynamic var  userName : String?
    dynamic var  id : String = ""
    dynamic var  nameModel: RealmNameModel?
    dynamic var  registered: String?
    
    convenience init(
        gender: String?,
        email: String?,
        phone: String?,
        nationality: String?,
        userName: String?,
        id: String,
        nameModel: RealmNameModel?,
        pictureModel: RealmPictureModel?,
        registered: String?
        )
    {
        self.init()
        
        self.gender = gender
        self.email = email
        self.phone = phone
        self.nationality = nationality
        self.userName = userName
        self.id = id
        self.nameModel = nameModel
        self.registered = registered
    }
    
    convenience init(userModel: UserModel) {
        self.init(
            gender: userModel.gender,
            email: userModel.email,
            phone: userModel.phone,
            nationality: userModel.nationality,
            userName: userModel.userName,
            id: userModel.id,
            nameModel: RealmNameModel(
                nameModel: userModel.nameModel
            ),
            pictureModel: RealmPictureModel(
                pictureModel: userModel.pictureModel
                ),
            registered: userModel.registered
        )
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return RealmUserModel(
            gender: self.gender,
            email: self.email,
            phone: self.phone,
            nationality: self.nationality,
            userName: self.userName,
            id: self.id,
            nameModel: self.nameModel?.copy() as? RealmNameModel,
            pictureModel: self.pictureModel?.copy() as? RealmPictureModel,
            registered: self.registered
        )
    }
}

// MARK: - RealmName model
class RealmNameModel: Object, NSCopying {
    dynamic var title: String?
    dynamic var name: String?
    dynamic var surname: String?
    
    convenience init(title: String?, name: String?, surname: String?) {
        self.init()
        
        self.title = title
        self.name = name
        self.surname = surname
    }
    convenience init(nameModel: NameModel?) {
        self.init(title: nameModel?.title, name: nameModel?.name, surname: nameModel?.surname)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return RealmNameModel(
            title: self.title,
            name: self.name,
            surname: self.surname
        )
    }
}

// MARK: - RealmPicture model
class RealmPictureModel: Object, NSCopying  {
    dynamic var large : URL?
    dynamic var medium : URL?
    dynamic var thumbnail : URL?
    
    convenience init(
        large : URL?,
        medium : URL?,
        thumbnail : URL?
        ) {
        self.init()
        
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
    }
    convenience init(pictureModel: PictureModel?) {
        self.init(large: pictureModel?.large, medium: pictureModel?.medium, thumbnail: pictureModel?.thumbnail)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return RealmPictureModel(
            large: self.large,
            medium: self.medium,
            thumbnail: self.thumbnail
        )
    }
}
