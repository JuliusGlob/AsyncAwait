import UIKit

enum NetworkError: Error {
    case badUrl
    case decodingError
    case invalidId
}

struct CredictScore: Decodable {
    let score: Int
}

struct Constants {
    struct Urls {
        static func equifax(userId: Int) -> URL? {
            return URL(string: "https://ember-sparkly-rule.glitch.me/equifax/credit-score/\(userId)")
        }
        
        static func experian(userId: Int) -> URL? {
            return URL(string: "https://ember-sparkly-rule.glitch.me/experian/credit-score/\(userId)")
        }
        
    }
}

func calculateAPR(creditScores: [CredictScore]) -> Double {
    let sum = creditScores.reduce(0) { next, credit in
        return next + credit.score
    }
    // calculate the APR based on the scores
    return Double((sum/creditScores.count) / 100)
}

func getAPR(userId: Int) async throws -> Double {
    
    // adding a condition to cancel the task
    if userId % 2 == 0 {
        throw NetworkError.invalidId
    }
    
    guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
          let experianUrl = Constants.Urls.experian(userId: userId) else  {
              throw NetworkError.badUrl
          }
    // instead of using the try await we will use an async let to create concurrent tasks
    async let (equifaxData, _) = URLSession.shared.data(from: equifaxUrl)
    async let (experianData, _) = URLSession.shared.data(from: experianUrl)
    
    let equifaxCreditScore = try? JSONDecoder().decode(CredictScore.self, from: try await equifaxData)
    let experionCreditScore = try? JSONDecoder().decode(CredictScore.self, from: try await experianData)
    
    guard let equifaxCreditScore = equifaxCreditScore,
          let experionCreditScore = experionCreditScore else  {
              throw NetworkError.decodingError
          }
    return calculateAPR(creditScores: [equifaxCreditScore, experionCreditScore])
}

let ids = [1,2,3,4,5]
var invalidIds: [Int] = []


//Task.init {
//    for id in ids {
//        // we set a do catch in order to verify a task has not been canceled, if it has it will show the error and continue with the queue
//        do {
//            // an alternative would be a coalescence with Task.isCancelled boolean
//            try Task.checkCancellation()
//            let apr = try await getAPR(userId: id)
//            print("\(id) : - \(apr)")
//        }
//        catch {
//            print(error)
//            invalidIds.append(id)
//        }
//    }
//    print("The invalid ids received are: \(invalidIds)")
//}
/*
 another option with Task groups
 */

func getAPRForAllUsers(ids: [Int]) async throws -> [Int: Double] {
    var userAPR: [Int: Double] = [:]
    try await withThrowingTaskGroup(of: (Int, Double).self, body: { group in
        
        for id in ids {
            group.addTask {
                return (id, try await getAPR(userId: id))
            }
        }
        for try await(id, apr) in group {
            userAPR[id] = apr
        }
    })
    return userAPR
}

Task.init {
    let userAPRs = try await getAPRForAllUsers(ids: ids)
    print(userAPRs)
}
