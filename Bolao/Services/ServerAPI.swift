//
//  ServerAPI.swift
//  Bolao
//
//  Created by Rafael Zane on 18/05/18.
//  Copyright © 2018 DaniloCharantola. All rights reserved.
//

import Alamofire
import Foundation

class ServerAPI {
    
    static let baseURL = "http://192.168.0.103:8080/"

    
    static func fetchAll<T: Codable & DBEntity>(completion: @escaping ([T]?) -> Void) {
        
        guard let url = URL(string: baseURL + T.urlExtention() + "/") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote \(T.urlExtention()): \(String(describing: response.result.error))")
                        completion(nil)
                    return
                }

                guard let value = response.result.value as? [[String : Any]] else {
                        print("Malformed data received from fetchAll service")
                        completion(nil)
                        return
                }
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    do {
                        let result = try JSONDecoder().decode([T].self, from: jsonData)
                        completion(result)
                        return
                    } catch {
                        print(error)
                    }
                    
                }
                completion(nil)
        }
    }
    
    static func fetchEntity<T: Codable & DBEntity>(id: String, completion: @escaping (T?) -> Void) {
        
        guard let url = URL(string: baseURL + T.urlExtention() + "/" + id) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote \(T.urlExtention()): \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [[String : Any]] else {
                    print("Malformed data received from fetchAll service")
                    completion(nil)
                    return
                }
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        completion(result)
                    } catch {
                        print(error)
                    }
                    
                }
                completion(nil)
        }
                
    }
}
