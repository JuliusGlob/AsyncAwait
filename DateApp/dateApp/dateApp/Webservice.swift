//
//  Webservice.swift
//  dateApp
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

class Webservice {
    
    func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "https://ember-sparkly-rule.glitch.me/current-date") else {
            fatalError("url is incorrect")
        }
        /// await will be used to wait for the urlsession to finish in order to continue operation
        let (data, _) = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
}
