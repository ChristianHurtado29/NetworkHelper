//
//  Podcast.swift
//  NetworkHelper
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Margiett Gil. All rights reserved.
//

import Foundation

struct AppleSearchAPI: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let artistName: String
    let collectionName: String
}
