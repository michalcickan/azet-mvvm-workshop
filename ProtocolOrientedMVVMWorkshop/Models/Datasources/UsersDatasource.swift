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
