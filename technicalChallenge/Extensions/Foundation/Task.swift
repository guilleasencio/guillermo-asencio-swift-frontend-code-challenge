//
//  Task.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 28/4/24.
//

import Foundation

public extension Task {
    func store(in set: inout Set<Task>) {
        set.insert(self)
    }
}

public extension Set<Task<Void, Never>> {
    func awaitAll() async {
        for task in self {
            await task.value
        }
    }
}
