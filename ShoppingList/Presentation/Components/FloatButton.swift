//
//  FloatButtonView.swift
//  ShoppingList
//
//  Created by Paulo José on 25/06/21.
//

import UIKit

class FloatButton: UIButton {
    
    enum CustomType {
        case add
    }
    
    let type: CustomType
    
    init(type: CustomType = .add) {
        self.type = type
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRounded()
    }
    
}

extension FloatButton: ViewCode {
    func buildViewHierarchy() {
        self.backgroundColor = .darkGray
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        switch type {
        case .add:
            self.setImage(.add, for: .normal)
        }
    }
}
