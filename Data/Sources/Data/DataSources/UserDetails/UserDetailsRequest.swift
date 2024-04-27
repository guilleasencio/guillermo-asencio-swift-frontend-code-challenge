//
//  UserDetailsRequest.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

struct UserDetailsRequest: NetworkRequest {
    var path: String = "/users"
    
    init(username: String) {
        self.path += "/\(username)"
    }
}
