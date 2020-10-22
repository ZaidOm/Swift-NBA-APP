//
//  StandingsRequest.swift
//  NBA App
//
//  Created by Zaid Omar on 2020-10-22.
//  Copyright © 2020 Zaid Omar. All rights reserved.
//

import Foundation

enum StandingsError:Error {
    case noDataAvailable
    case cannotProcessData
}

struct StandingsRequest {
    let resourceURL:URL
    let API_KEY = "08eb15beaf5b4bb89e301c11adc44aee"
    
    init() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString =
            "https://api.sportsdata.io/v3/nba/scores/json/Standings/\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getStandings (completion: @escaping(Result<[StandingsDetail], StandingsError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let standingsReponse = try decoder.decode(StandingsResponse.self, from: jsonData)
                let standingsDetails = standingsReponse.response.standings
                completion(.success(standingsDetails))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}
