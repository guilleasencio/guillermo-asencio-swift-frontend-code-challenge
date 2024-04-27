//
//  User.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public struct User {
    public let username: String
    public let avatar: String

    public init(username: String, avatar: String) {
        self.username = username
        self.avatar = avatar
    }
}
