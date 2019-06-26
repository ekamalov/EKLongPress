//
//  HitFeed.swift
//  EKLongTouch
//
//  Created by Erik Kamalov on 6/13/19.
//  Copyright © 2019 E K. All rights reserved.
//

import Foundation

typealias HitFeeds = [HitFeed]

struct HitFeed: Codable {
    let preview, name, channel: String
    let seasongs: Int
}
extension HitFeed {
    var title:String {
        return name
    }
    var subTitle:String {
        return self.channel + " 𐄁 \(self.seasongs) seasons"
    }
}
