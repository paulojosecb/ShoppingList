//
//  BulletPointView.swift
//  ShoppingList
//
//  Created by Paulo José on 18/06/21.
//

import UIKit

class BulletPointView: UIView {
    
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    
    lazy var centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerView.makeRounded()
    }

}

extension BulletPointView: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(centerView)
    }
    
    func setupConstraints() {
        self.heightConstraint = centerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        self.heightConstraint?.isActive = true
        
        self.widthConstraint = centerView.widthAnchor.constraint(equalTo: self.widthAnchor)
        self.widthConstraint?.isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }

}
