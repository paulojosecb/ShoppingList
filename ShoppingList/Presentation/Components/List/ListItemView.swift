//
//  ListItemView.swift
//  ShoppingList
//
//  Created by Paulo José on 11/06/21.
//

import UIKit

class ListItemView: UIView, ShadowedView {
    var fillBackgroundColor: CGColor = UIColor.white.cgColor
    var hasSetupShadow: Bool

    lazy var bulletPointView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "List name"
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.text = "0 itens"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "R$ 10000.00"
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        self.hasSetupShadow = false
        
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bulletPointView.makeRounded()
        self.setupShadow()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

}

extension ListItemView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(bulletPointView)
        self.addSubview(listNameLabel)
        self.addSubview(detailLabel)
        self.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        self.bulletPointView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.bulletPointView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        self.bulletPointView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        self.bulletPointView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        self.listNameLabel.leadingAnchor.constraint(equalTo: bulletPointView.trailingAnchor, constant: 16).isActive = true
        self.listNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        self.listNameLabel.heightAnchor.constraint(equalToConstant: self.listNameLabel.intrinsicContentSize.height).isActive = true
        self.listNameLabel.trailingAnchor.constraint(equalTo: self.priceLabel.leadingAnchor, constant: -8).isActive = true
        
        self.detailLabel.leadingAnchor.constraint(equalTo: self.listNameLabel.leadingAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: self.listNameLabel.trailingAnchor).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: self.listNameLabel.bottomAnchor, constant: 8).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: self.detailLabel.intrinsicContentSize.height).isActive = true
        
        self.priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.listNameLabel.trailingAnchor, constant: 8).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.priceLabel.widthAnchor.constraint(equalToConstant: self.priceLabel.intrinsicContentSize.width).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: self.priceLabel.intrinsicContentSize.height).isActive = true
    }
    
    func setupAdditionalConfiguration() {

    }
    
}
