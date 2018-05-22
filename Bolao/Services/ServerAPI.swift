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
    
    // With Alamofire
    func fetchAllBets(completion: @escaping ([MatchScore]?) -> Void) {
        guard let url = URL(string: "http://192.168.0.104:8080/matchScores/") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote bets: \(String(describing: response.result.error))")
                        completion(nil)
                    return
                }

                guard let value = response.result.value as? [[String : Any]] else {
                        print("Malformed data received from fetchAllBets service")
                        completion(nil)
                        return
                }
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    do {
                        let scores = try JSONDecoder().decode([MatchScore].self, from: jsonData)
                        completion(scores)
                    } catch {
                        print(error)
                    }
                    
                }
                completion(nil)
        }
    }
    
}
