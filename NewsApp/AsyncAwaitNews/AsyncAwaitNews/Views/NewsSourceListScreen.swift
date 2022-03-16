//
//  NewsSourceListScreen.swift
//  AsyncAwaitNews
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import SwiftUI

struct NewsSourceListScreen: View {
    
    @StateObject private var newsSourceListViewModel = NewsSourceListViewModel()
    
    var body: some View {
        
        NavigationView {
        
        List(newsSourceListViewModel.newsSources, id: \.id) { newsSource in
            NavigationLink(destination: NewsListScreen(newsSource: newsSource)) {
                NewsSourceCell(newsSource: newsSource)
            }
        }
        .listStyle(.plain)
            ///we use task now to replace on appear since we will be performing an async task.
        .task({
            await newsSourceListViewModel.getSources()
        })
        .navigationTitle("News Sources")
        .navigationBarItems(trailing: Button(action: {
            // refresh the news
            Task.init {
                await newsSourceListViewModel.getSources()
            }
        }, label: {
            Image(systemName: "arrow.clockwise.circle")
        }))
        }
    }
}

struct NewsSourceListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsSourceListScreen()
    }
}

struct NewsSourceCell: View {
    
    let newsSource: NewsSourceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(newsSource.name)
                .font(.headline)
            Text(newsSource.description)
        }
    }
}
