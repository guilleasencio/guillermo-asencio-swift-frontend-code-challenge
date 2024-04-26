//
//  HomeModels.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 25/4/24.
//

import UIKit

enum Home {
  enum UserDetails {
    struct Request {
        let term: String
    }

    struct Response {
        let errorMessage: String?
    }

    struct ViewModel {
        let errorMessage: String?
    }
  }
}
