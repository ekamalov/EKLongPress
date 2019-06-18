//
//  APIService.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/14/19.
//  Copyright © 2019 E K. All rights reserved.
//

import Foundation

class APIService {
   class func fetchPopularPhoto(completion:  @escaping (Result<HitFeeds,Error>) -> Void) {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "HitFeed", ofType: "json") {
                do {
                    let fileUrl = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: fileUrl)
                    let res = try JSONDecoder().decode(HitFeeds.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}



