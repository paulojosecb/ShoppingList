//
//  ShadowedView.swift
//  ShoppingList
//
//  Created by Paulo José on 11/06/21.
//

import UIKit

protocol ShadowedView: UIView {
    var hasSetupShadow: Bool { get set }
    var fillBackgroundColor: CGColor { get set }
}

extension ShadowedView {
    func setupShadow() {
        if hasSetupShadow { return }
        
        let shadowLayer = CAShapeLayer()
            
        shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: 20).cgPath
        
        shadowLayer.fillColor = fillBackgroundColor
        shadowLayer.shadowPath = shadowLayer.path
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 3
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
