//
//  UIView.swift
//  technicalChallenge
//
//  Created by Guillermo Asencio Sanchez on 26/4/24.
//

import UIKit

extension UIView {
    func addSubviewForAutolayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
