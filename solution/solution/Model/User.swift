//
//  User.swift
//  solution
//
//  Created by Lucas Goes Valle on 22/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias JSONArray = [[String: Any]]

struct User: Mappable {
    
    var id: Int
    var facebookId: String
    var image: String
    var name: String
    var resume: String
    
    init(mapper: Mapper) {
        self.id = mapper.keyPath("id")
        self.facebookId = mapper.keyPath("facebookId")
        self.image = mapper.keyPath("image")
        self.name = mapper.keyPath("name")
        self.resume = mapper.keyPath("resume")
    }
}

