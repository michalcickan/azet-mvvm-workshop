//
//  Request.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol JSONValue : Mappable {
    var jsonValue : [String: Any] { get }
}

extension JSONValue {
    var jsonValue : [String: Any] {
        return Mapper().toJSON(self)
    }
}

class Request<T: Mappable> {
    /*private(set)*/ var parameters : JSONValue?
    var url : String {
        return Config.BaseURL
    }
    typealias RequstCompletionHandler = (_ success: Bool, _ object: T?,_ error: Error?) -> Void
    typealias ObjecType = T
    
    fileprivate lazy var manager : Alamofire.SessionManager = {
        return Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }()
    
    var request : DataRequest {
        return manager.request(
            url,
            parameters: self.parameters?.jsonValue
        )
    }
    
    func performRequest(completion: RequstCompletionHandler?) {
        request.responseJSON(
            queue: DispatchQueue.global(),
            options: .allowFragments,
            completionHandler: { response in
                var result : ObjecType?
                var error: Error?
                
                switch response.result {
                case .success(let json):
                    result = Mapper<ObjecType>().map(JSONObject: json)
                case .failure(let err):
                    error = err
                }
                
                DispatchQueue.main.async {
                    completion?(error == nil, result, error)
                }
        })
        
    }
}
