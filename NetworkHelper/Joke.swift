//
//  Joke.swift
//  NetworkHelper
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Margiett Gil. All rights reserved.
//

import Foundation

struct Joke: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
