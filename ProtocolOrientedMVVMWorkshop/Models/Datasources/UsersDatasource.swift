//
//  UsersDatasource.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation

protocol UsersDatasourceProtocol {
    var userViewModels: [UserDetailCellDatasource]? { get }
    func fetchUsers(completionHandler: ( (_ success: Bool) -> Void))
}

class RESTUsersDatasource: UsersDatasourceProtocol {
    fileprivate var parameters = UserRequestParameters()
    fileprivate lazy var request : Request<UserListModel> = {
        let req = Request<UserListModel>()
        req.parameters = self.parameters
        
        return req
    }()
    
    fileprivate(set) var userViewModels: [UserDetailCellDatasource]?
    
    struct UserDataSourceViewModel: UserDetailCellDatasource {
        var profileImageUrl: URL?
        var nick: String
        var description: String
    }
    func fetchUsers(completionHandler: ((Bool) -> Void)) {
        request.performRequest(completion: {[weak self] success, userList, error in
            guard let strongSelf = self else { return }
            
            if let users = userList?.users, success {
                let initialIndex = strongSelf.userViewModels?.count ?? 0
                
                
            }
        })
    }
    
}
