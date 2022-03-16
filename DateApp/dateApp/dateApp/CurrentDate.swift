//
//  CurrentDate.swift
//  dateApp
//
//  Created by Julio Ismael Robles on 19/01/2022.
//

import Foundation

struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}
