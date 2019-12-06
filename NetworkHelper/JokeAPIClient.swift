//
//  JokeAPIClient.swift
//  NetworkHelper
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Margiett Gil. All rights reserved.
//

import Foundation

struct JokeAPIClient {
    
    // TODO: refactor into using a completion handler to get back jokes
    static func getJokes() -> [Joke] {
        let endpointURLString = "https://official-joke-api.appspot.com/jokes/programming/ten"
        var jokes = [Joke]()
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                do {
                    jokes = try JSONDecoder().decode([Joke].self, from: data)
                    print("there are \(jokes.count) jokes")
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }
        return jokes
    }
}
