//
//  Constants.swift
//  Timcoo-cliente
//
//  Created by Lucas Valle on 03/11/17.
//  Copyright © 2017 Timcoo. All rights reserved.
//

import UIKit

struct Constants {
    static let googleApiKey = "AIzaSyCnfecshrTH5eJVzlWjn4MORCZiMUht3-0"
}

struct ConstantsAPI {
    static var baseURLMaps = URL(string: "https://maps.googleapis.com/maps/api/")!
    static let apiPath = ""
    static let authenticationHeaders = ["access-token", "client", "uid"]
    static let authenticationHeadersDefaultsKey = "authenticationHeaders"
}

extension UserDefaults {
    enum keys {
        static var Team = "Team"
        static var UserLogged = "UserLogged"
        static var DeviceToken = "DeviceToken"
    }
}

extension Notification.Name {
    static let nextCardNotification = Notification.Name("nextCardNotification")
    static let updateScoreContent = Notification.Name("updateScoreContent")
    static let lastCardNotification = Notification.Name("lastCardNotification")
    static let kAVPlayerViewControllerDismissingNotification = Notification.Name.init("dismissing")
}
