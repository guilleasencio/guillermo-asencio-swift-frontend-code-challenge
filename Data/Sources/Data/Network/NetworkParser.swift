//
//  NetworkResponseParser.swift
//
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import Foundation

enum NetworkParser {
    static func parse<MyDecodable: Decodable>(data: Data, entityType: MyDecodable.Type) throws -> MyDecodable {
        let decoder = JSONDecoder()
        var returnValue: MyDecodable
        do {
            let data = (data.isEmpty) ? try JSONSerialization.data(withJSONObject: [:]) : data
            returnValue = try decoder.decode(entityType, from: data)
        } catch {
            if let derror = error as? DecodingError {
                #if DEBUG
                print("**********************************************************")
                print(derror.localizedDescription)
                print("\(derror)")
                print("**********************************************************")
                #endif
            }
            throw NetworkError(errorCode: .parseError, errorMessage: "Error when parsing the response.")
        }
        return returnValue
    }
}
