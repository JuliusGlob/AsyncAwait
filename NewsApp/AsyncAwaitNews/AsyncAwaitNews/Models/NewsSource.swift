//
//  NewsSource.swift
//  AsyncAwaitNews
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
