//
//  ResultPeople.swift
//  starWars
//
//  Created by Никита on 04/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
 
struct Result {
    let count: Int!
    let next: String?
    let previous: String?
    let results: [Person]!
}

extension Result: Decodable {
    enum ResultCodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }

    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultCodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try container.decode(String?.self, forKey: .next)
        previous = try container.decode(String?.self, forKey: .previous)
        results = try container.decode([Person].self, forKey: .results)
    }

}
