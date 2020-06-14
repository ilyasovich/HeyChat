//
//  Constants.swift
//  HeyChat
//
//  Created by Aman Ilyasovich on 6/1/20.
//  Copyright © 2020 Aman Ilyasovich. All rights reserved.
//

import Foundation

struct C {
    static let appName = "👋 Hey Chat!"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let lightGrey = "BrandLightGrey"
        static let darkGrey = "BrandDarkGrey"
        static let green = "BrandGreen"
        static let black = "BrandBlack"
    }

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}


