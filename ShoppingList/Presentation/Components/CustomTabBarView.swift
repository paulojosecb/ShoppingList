//
//  CustomTabBarView.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import UIKit

class CustomTabBarView: UIView {
    
    lazy var roundedCentralButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CustomTabBarView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(roundedCentralButton)
    }
    
    func setupConstraints() {
        self.roundedCentralButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        self.roundedCentralButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.roundedCentralButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.roundedCentralButton.centerYAnchor.constraint(equalTo: self.topAnchor, constant: -27).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
