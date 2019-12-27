//
//  Network.swift
//  GitHubTask
//
//  Created by Shehata on 12/25/19.
//  Copyright © 2019 shehata. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Network: NSObject {
    
    private override init() {
        super.init()
    }
    static let shared = Network()
    
    func getData<T: Codable>(_ decoder: T.Type, url: URL, parameters: [String:Any]?, method: HTTPMethod = .get, compaletion: ((_ error: String? , _ data: T?) -> Void)? = nil )  {
        
        print(parameters)
        var header = ["X-localization" : "ar"
            // "Accept" : "application/json"
        ]
        
            header["Authorization"] = "Bearer 93b804517c3fb09b05acb15e69a37868fb06b3a2)"
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil )
            .responseJSON { (response) in
                print(url)
                guard let compaletion = compaletion else {return}
                switch response.result{
                case .failure(let err):
                    debugPrint("failure",err)
                    if err.localizedDescription.contains("JSON"){
                        compaletion("Server error",nil)
                        return
                    }
                case .success(_) :
                    guard let responseData = response.data
                        else{
                            compaletion(response.error?.localizedDescription ?? "Error", nil)
                            return
                    }
                    let json = JSON(response.value ?? [:])
                    print(json)
                    do{
                        let data = try newJSONDecoder().decode(T.self, from: responseData)
                        compaletion(nil,data)
                    }catch let error {
                        compaletion("Servar Error.", nil)
                        debugPrint(error)
                    }
                    return
                }
        }
    } 
}


func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}
