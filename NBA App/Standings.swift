//
//  Standings.swift
//  NBA App
//
//  Created by Zaid Omar on 2020-10-22.
//  Copyright © 2020 Zaid Omar. All rights reserved.
//

import Foundation

struct StandingsResponse: Decodable {
    var response:Standings
}

struct Standings: Decodable {
    var standings:[StandingsDetail]
}

struct StandingsDetail: Decodable {
    var startTime: String
    var date:StandingsDate
}

struct StandingsDate: Decodable {
    var date: String
}
