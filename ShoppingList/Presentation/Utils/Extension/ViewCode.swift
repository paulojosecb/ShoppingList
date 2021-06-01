//
//  ViewCode.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import Foundation

/**
 This protocol defines a template to construct UIView Programatically.
*/
protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {

    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.setupAdditionalConfiguration()
    }

}
