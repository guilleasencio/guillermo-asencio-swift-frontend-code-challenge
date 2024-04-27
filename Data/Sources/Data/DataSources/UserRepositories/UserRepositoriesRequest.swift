//
//  UserRepositoriesRequest.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

struct UserRepositoriesRequest: NetworkRequest {
    var path = "/users/%@/repos"

    init(username: String) {
        self.path = String(format: path, username)
    }
}
