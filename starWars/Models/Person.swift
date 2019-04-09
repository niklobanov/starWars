//
//  Person.swift
//  starWars
//
//  Created by Никита on 03/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class Person: Object, Decodable {
    dynamic var name: String = ""
    dynamic var height: String = ""
    dynamic var mass: String = ""
    dynamic var hairColor: String = ""
    dynamic var skinColor: String = ""
    dynamic var eyeColor: String = ""
    dynamic var birtYear: String = ""
    dynamic var gender: String = ""
    dynamic var homeworld: String = ""
    let films  = RealmSwift.List<String>()
    let species  = RealmSwift.List<String>()
    let vehicles = RealmSwift.List<String>()
    let starships = RealmSwift.List<String>()
    dynamic var created: String = ""
    dynamic var edited: String = ""
    dynamic var url: String = ""


    enum PersonCodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birtYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(String.self, forKey: .height)
        mass = try container.decode(String.self, forKey: .mass)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        birtYear = try container.decode(String.self, forKey: .birtYear)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        gender = try container.decode(String.self, forKey: .gender)
        homeworld = try container.decode(String.self, forKey: .homeworld)
        let film = try container.decode([String].self, forKey: .films)
        films.append(objectsIn: film)
        let specie = try container.decode([String].self, forKey: .species)
        species.append(objectsIn: specie)
        let vehicle = try container.decode([String].self, forKey: .vehicles)
        vehicles.append(objectsIn: vehicle)
        let starship = try container.decode([String].self, forKey: .starships)
        starships.append(objectsIn: starship)
        created = try container.decode(String.self, forKey: .created)
        edited = try container.decode(String.self, forKey: .edited)
        url = try container.decode(String.self, forKey: .url)
        super.init()
    }


    override static func primaryKey() -> String? {
        return "name"
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}




