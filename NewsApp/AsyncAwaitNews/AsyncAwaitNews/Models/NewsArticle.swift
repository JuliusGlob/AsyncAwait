//
//  NewsArticle.swift
//  AsyncAwaitNews
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation


struct NewsArticleResponse: Decodable {
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let content: String?
    let publishedAt: String
    let urlToImage: String?
}

