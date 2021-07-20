//
//  CheckoutBarView.swift
//  ShoppingList
//
//  Created by Paulo José on 25/06/21.
//

import UIKit

class CheckoutBarView: UIView {
    
    struct ViewModel {
        let total: Double
        let cartAction: (() -> ())?
    }
    
    public var viewModel: ViewModel {
        didSet {
            subTotalLabel.text = "SubTotal: R$\(viewModel.total.rounded(toPlaces: 2))"
        }
    }
    
    static var height: CGFloat = 84

    lazy var subTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SubTotal: R$ 0,00"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var cartIconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CheckoutBarView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(subTotalLabel)
        self.addSubview(cartIconView)
    }
    
    func setupConstraints() {
        self.subTotalLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.subTotalLabel.heightAnchor.constraint(equalToConstant: self.subTotalLabel.intrinsicContentSize.height).isActive = true
        self.subTotalLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        self.subTotalLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        self.cartIconView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        self.cartIconView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.cartIconView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        self.cartIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .darkGray
    }
}
