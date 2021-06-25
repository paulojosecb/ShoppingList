//
//  FloatButtonView.swift
//  ShoppingList
//
//  Created by Paulo José on 25/06/21.
//

import UIKit

class FloatButton: UIButton {

    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layoutSubviews()
        makeRounded()
    }
    
}

extension FloatButton: ViewCode {
    func buildViewHierarchy() {
        self.setImage(.add, for: .normal)
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
