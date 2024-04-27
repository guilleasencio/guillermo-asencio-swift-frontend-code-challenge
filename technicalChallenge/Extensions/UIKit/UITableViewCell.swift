//
//  UITableViewCell.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 27/4/24.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
