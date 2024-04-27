//
//  Repository.swift
//  
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import Foundation

public struct Repository {
    public let name: String
    public let language: String?

    public init(name: String, language: String?) {
        self.name = name
        self.language = language
    }
}
