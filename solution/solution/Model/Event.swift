//
//  Event.swift
//  solution
//
//  Created by Lucas Goes Valle on 23/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import Foundation

struct Event: Mappable {
    
    var id: Int
    var name: String
    var date: String
    var place: String
    var description: String
    
    init(mapper: Mapper) {
        self.id = mapper.keyPath("id")
        self.name = mapper.keyPath("name")
        self.date = mapper.keyPath("date")
        self.place = mapper.keyPath("place")
        self.description = mapper.keyPath("description")
    }
}

