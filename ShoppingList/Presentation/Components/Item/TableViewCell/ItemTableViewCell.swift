//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ItemTableViewCell.self)
    static let height: CGFloat = 80
    
    struct ViewModel {
        let itemName: String
        let itemDescription: String
        let quantity: Int
        let price: Double
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            itemNameLabel.text = viewModel.itemName
            itemDescription.text = viewModel.itemDescription
            priceLabel.text = "R$\(viewModel.price)"
        }
    }
        
    lazy var bulletPointView: BulletPointView = {
        let view = BulletPointView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Defaul itemn name"
        return label
    }()
    
    lazy var itemDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "Defaul brand"
        return label
    }()
    
    lazy var itemPriceView: ItemPriceView = {
        let view = ItemPriceView(viewModel: .init(quantity: self.viewModel?.quantity ?? 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$00,00"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

}

extension ItemTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(bulletPointView)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemDescription)
        contentView.addSubview(itemPriceView)
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        bulletPointView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        bulletPointView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        bulletPointView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bulletPointView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
        
        itemPriceView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        itemPriceView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        itemPriceView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        itemPriceView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
        
        itemNameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: bulletPointView.trailingAnchor, constant: 16).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: itemPriceView.leadingAnchor, constant: 16).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: itemNameLabel.intrinsicContentSize.height).isActive = true
        
        itemDescription.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 8).isActive = true
        itemDescription.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor).isActive = true
        itemDescription.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor).isActive = true
        itemDescription.heightAnchor.constraint(equalToConstant: itemDescription.intrinsicContentSize.height).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
