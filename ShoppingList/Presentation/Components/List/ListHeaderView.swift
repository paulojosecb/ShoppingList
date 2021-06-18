//
//  ListHeaderView.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ListHeaderView: UIView, ShadowedView {
    
    var fillBackgroundColor: CGColor
    var hasSetupShadow: Bool
    
    lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "List name"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description label"
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    override init(frame: CGRect) {
        self.hasSetupShadow = false
        self.fillBackgroundColor = UIColor.clear.cgColor
        
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupShadow()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

}

extension ListHeaderView: ViewCode {
    func buildViewHierarchy() {
        addSubview(listNameLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        listNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        listNameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        listNameLabel.heightAnchor.constraint(equalToConstant: self.listNameLabel.intrinsicContentSize.height).isActive = true
        listNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: listNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: listNameLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: listNameLabel.trailingAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.intrinsicContentSize.height).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
}
