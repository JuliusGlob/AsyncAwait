//
//  Constants.swift
//  AsyncAwaitNews
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

struct Constants {
    ///An api key can be found at newsapi.org
    static let apiKey: String = "b103bbbcebc24c588cec0a974aa6a7c6"

    struct Urls {
        
        static func topHeadlines(by source: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=\(Constants.apiKey)")
        }
                
        static let sources: URL? = URL(string: "https://newsapi.org/v2/sources?apiKey=\(Constants.apiKey)")
    }
    
}
