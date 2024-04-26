//
//  User.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public struct User {
    let username: String
    let avatar: String

    public init(username: String, avatar: String) {
        self.username = username
        self.avatar = avatar
    }
}
