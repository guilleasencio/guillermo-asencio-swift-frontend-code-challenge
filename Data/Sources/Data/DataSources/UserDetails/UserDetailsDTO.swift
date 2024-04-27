//
//  UserDetailsDTO.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

struct UserDetailsDTO: Decodable {
    let username: String
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatar = "avatar_url"
    }
}
