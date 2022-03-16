//
//  ContentView.swift
//  dateApp
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject private var currentDateListVM = CurrentDateListViewModel()
    
    var body: some View {
        NavigationView {
            List(currentDateListVM.currentDates, id: \.id) { currentDate in
                Text(currentDate.date)
            }.listStyle(.plain)
            
                .navigationTitle("Dates")
                .navigationBarItems(trailing: Button(action: {
                    // button action
                    Task.init {
                        await currentDateListVM.populateDates()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                }))
                .task {
                    /// works as an onappear designed to be used for async operations
                    await currentDateListVM.populateDates()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
