//
//  UsersDatasource.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation

protocol UsersDatasourceProtocol {
    var userViewModels: [UserDetailCellDatasource] { get }
    func fetchUsers(completionHandler: ( @escaping (_ success: Bool) -> Void))
    func userTapped(atIndex index: Int)
}

class RESTUsersDatasource: UsersDatasourceProtocol {
    fileprivate var parameters = UserRequestParameters()
    fileprivate lazy var request : Request<UserListModel> = {
        let req = Request<UserListModel>()
        req.parameters = self.parameters
        
        return req
    }()
    
    fileprivate(set) var userViewModels: [UserDetailCellDatasource] = []
    
    func fetchUsers(completionHandler: @escaping (_ success: Bool) -> Void) {
        request.performRequest(completion: {[weak self] success, userList, error in
            guard let strongSelf = self else { return }
            
            if let users = userList?.users, success {
                strongSelf.userViewModels.append(contentsOf:
                    users.map({
                        UserDataSourceViewModel(user: $0)
                    })
                )
                
                completionHandler(success)
            } else {
                self?.fetchUsers(completionHandler: completionHandler)
            }
        })
    }
    func userTapped(atIndex index: Int) {
        guard let user = (self.userViewModels[index] as? UserDataSourceViewModel)?.userModel else { return }
        
        RealmManager.writeObject(
            RealmUserModel(
                userModel: user
        ), update: true)
    }
}

extension RESTUsersDatasource {
    struct UserDataSourceViewModel: UserDetailCellDatasource {
        var userModel: UserModel?
        
        init(user: UserModel) {
            self.userModel = user
        }
        
        // MARK: - View models getters
        
        var profileImageUrl: URL? {
            return userModel?.pictureModel?.medium
        }
        var nick: String {
            return userModel?.userName ?? ""
        }
        var description: String {
            var descArray = [String]()
            if let nationality = userModel?.nationality {
                descArray.append(nationality)
            }
            if let gender = userModel?.gender {
                descArray.append(gender)
            }
            return descArray.joined(separator: ", ")
        }
    }
}

class RealmDatasource: UsersDatasourceProtocol {
    func userTapped(atIndex index: Int) {
    }

    func fetchUsers(completionHandler: @escaping ((Bool) -> Void)) {
        let objects: [RealmUserModel]? = RealmManager.getObjects(nil)
        
        guard let objs = objects else { return }
        userViewModels.append(contentsOf: objs.map({
          RealmUserViewModel(realmUser: $0)
        })
        )
        completionHandler(true)
    }

    var userViewModels: [UserDetailCellDatasource] = []
    
    struct RealmUserViewModel: UserDetailCellDatasource {
        var realmUser: RealmUserModel?
        
        init(realmUser: RealmUserModel?) {
            self.realmUser = realmUser
        }
        // MARK: - View models getters
        var profileImageUrl: URL? {
            guard let strUrl = realmUser?.pictureModel?.medium else { return nil }
            
            return URL(string: strUrl)
        }
        var nick: String {
            return realmUser?.userName ?? ""
        }
        var description: String {
            var descArray = [String]()
            if let nationality = realmUser?.phone {
                descArray.append(nationality)
            }
            if let gender = realmUser?.gender {
                descArray.append(gender)
            }
            return descArray.joined(separator: ", ")
        }
    }

    
}
