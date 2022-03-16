//
//  NewsSourceListViewModel.swift.swift
//  AsyncAwaitNews
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

/// by using the main actor decorator we designate this class's properties to be run on the main thread
@MainActor
class NewsSourceListViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSourceViewModel] = []
    
    func getSources() async {
        do {
            let newSources = try await Webservice().fetchSources(url: Constants.Urls.sources)
            DispatchQueue.main.async {
                self.newsSources = newSources.map(NewsSourceViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
}

struct NewsSourceViewModel {
    
    fileprivate var newsSource: NewsSource
    
    var id: String {
        newsSource.id
    }
    
    var name: String {
        newsSource.name
    }
    
    var description: String {
        newsSource.description
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
