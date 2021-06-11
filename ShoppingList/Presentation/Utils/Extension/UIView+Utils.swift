//
//  UIView+Utils.swift
//  ShoppingList
//
//  Created by Paulo José on 01/06/21.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func addShadow(
       cornerRadius: CGFloat = 16,
       shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
       shadowOffset: CGSize = CGSize(width: 0.0, height: 6.0),
       shadowOpacity: Float = 0.3,
       shadowRadius: CGFloat = 8) {
      
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
