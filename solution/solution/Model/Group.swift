//
//  Group.swift
//  solution
//
//  Created by Lucas Goes Valle on 22/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

struct Group: Mappable {
    
    var id: Int
    var name: String
    var description: String
    var imageProfile: String
    var imageFolder: String
    var participants: [Int]?
    var category: String
    var date: Date?
    var departureName: String
    var departureLatitude: Double
    var departureLongitude: Double
    var arrivalName: String
    var arrivalLatitude: Double
    var arrivalLongitude: Double
    var estimatedTime: String
    var endTime: String
    var startTime: String
    var distance: String
    var level: String
    var whatsapp: String
    var instagram: String
    var categoryImage: UIImage
    var imageIcon: UIImage
    var degradeColor: UIColor
    
    init(mapper: Mapper) {
        self.id = mapper.keyPath("id")
        self.name = mapper.keyPath("name")
        self.description = mapper.keyPath("description")
        self.endTime = mapper.keyPath("endTime")
        self.startTime = mapper.keyPath("startTime")
        self.imageProfile = mapper.keyPath("imageProfile")
        self.imageFolder = mapper.keyPath("imageFolder")
        self.participants = mapper.keyPath("participants")
        self.category = mapper.keyPath("category")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateString : String? = mapper.keyPath("date")
        self.date = dateFormatter.date(from:dateString!)
        
        self.departureName = mapper.keyPath("departureName")
        self.departureLatitude = mapper.keyPath("departureLatitude")
        self.departureLongitude = mapper.keyPath("departureLongitude")
        self.arrivalName = mapper.keyPath("arrivalName")
        self.arrivalLatitude = mapper.keyPath("arrivalLatitude")
        self.arrivalLongitude = mapper.keyPath("arrivalLongitude")
        self.estimatedTime = mapper.keyPath("estimatedTime")
        self.distance = mapper.keyPath("distance")
        self.level = mapper.keyPath("level")
        self.whatsapp = mapper.keyPath("whatsapp")
        self.instagram = mapper.keyPath("instagram")
        if self.category == "corrida" {
            self.imageIcon = #imageLiteral(resourceName: "MapaCorrendo")
            self.categoryImage = #imageLiteral(resourceName: "correr")
            self.degradeColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:CGRect(x:0,y:0, width:400, height: 50),andColors:[UIColor(hexString:"f76b1c")!,UIColor(hexString:"ffb016")!])
        } else if self.category == "caminhada" {
            self.imageIcon = #imageLiteral(resourceName: "mapaCaminhada")
            self.categoryImage = #imageLiteral(resourceName: "caminhada")
            self.degradeColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:CGRect(x:0,y:0, width:400, height: 50),andColors:[UIColor(hexString:"3663F7")!,UIColor(hexString:"2DE3D6")!])
        } else if self.category == "ciclismo" {
            self.imageIcon = #imageLiteral(resourceName: "mapaBike")
            self.categoryImage = #imageLiteral(resourceName: "bike")
            self.degradeColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:CGRect(x:0,y:0, width:400, height: 50),andColors:[UIColor(hexString:"429321")!,UIColor(hexString:"B4EC51")!])
        } else {
            self.imageIcon = #imageLiteral(resourceName: "MapaCorrendo")
            self.categoryImage = #imageLiteral(resourceName: "correr")
            self.degradeColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:CGRect(x:0,y:0, width:400, height: 50),andColors:[UIColor(hexString:"f76b1c")!,UIColor(hexString:"ffb016")!])
        }
    }
}
