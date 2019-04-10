//
//  StarWarsAPI.swift
//  starWars
//
//  Created by Никита on 04/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
import Moya

enum Provider {
    case result(searching: String)
}

extension Provider: TargetType {
    var baseURL: URL {
        switch self {
        case .result(let searching):
            if searching.isEmpty {
                return URL(string: "https://swapi.co/api/people/?search=nil")!
            } else {
                guard let url = URL(string:  "https://swapi.co/api/people/?search=\(searching)") else {
                    return URL(string: "https://swapi.co/api/people/?search=nil")!
                }
                return url
            }
        }
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }

}


