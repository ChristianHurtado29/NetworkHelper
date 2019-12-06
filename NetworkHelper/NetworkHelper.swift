//
//  NetworkHelper.swift
//  NetworkHelper
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Christian Hurtado. All rights reserved.
//

import Foundation

//MARK: Singleton
// we need to make out NetworkHelper a singleTon
//this means there will only ever be one instance of this class
//throughout the application, at no point will someone be able to create a new instance example NetWorkHelper() will be a compiler error

// why class because we have reference ....
class NetworkHelper {
    
    // we will create a shared instance of the NetworkHelper
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we will make the default initializer private
    // required in order to be considered a singleton
    //also forbid anyone from creating an instance of NetworkHelper
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with urlString: String,
                         completion: @escaping (Result<Data, AppError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            // handle bad url error case
            completion(.failure(.badURL(urlString)))
            return
        }
        
        // two states on dataATask, resume() and suspended by default
        // suspended simply won't perform network request
        // this ultimately leads to debugging errors and time lost if you don't explicitly resume() requests
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            // check for client network errors
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // 2. downcast URLResponse (response) to HTTPURLResponse to get access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // 3. unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // 4. validata the the status code is in the 200 range otherwise it's a bad status code
            switch urlResponse.statusCode {
            case 200...299: break // everything went well here
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // 5. capture data as success case
            completion(.success(data))
            
        }
        dataTask.resume()
        
        
    }
}
