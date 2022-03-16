//
//  CurrentDateListViewModel.swift
//  dateApp
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

/// setting main actor will have all our functions be run on the main thread
@MainActor
class CurrentDateListViewModel: ObservableObject {
    @Published var currentDates: [CurrentDateViewModel] = []
    
    func populateDates() async {
        do {
            let currentDate = try await Webservice().getDate()
            if let currentDate = currentDate {
                let currentDateViewModel = CurrentDateViewModel(currentDate: currentDate)
                currentDates.append(currentDateViewModel)
            }
        } catch {
            print(error)
        }
    }
}

struct CurrentDateViewModel {
    let currentDate: CurrentDate
    
    var id: UUID {
        currentDate.id
    }
    
    var date: String {
        currentDate.date
    }
}
