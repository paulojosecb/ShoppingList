//
//  ItemPriceView.swift
//  ShoppingList
//
//  Created by Paulo José on 18/06/21.
//

import UIKit

class ItemPriceView: UIView {
    
    struct ViewModel {
        let quantity: Int
    }
    
    let viewModel: ViewModel
    
    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "unidades"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    init(viewModel: ItemPriceView.ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

}

extension ItemPriceView: ViewCode {
    func buildViewHierarchy() {
        addSubview(unitLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        unitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        unitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2).isActive = true
        unitLabel.heightAnchor.constraint(equalToConstant: unitLabel.intrinsicContentSize.height).isActive = true
        unitLabel.widthAnchor.constraint(equalToConstant: unitLabel.intrinsicContentSize.width).isActive = true
        

        descriptionLabel.topAnchor.constraint(equalTo: unitLabel.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.intrinsicContentSize.height).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
    }

}
