//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by Paulo José on 01/06/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let name: String
        let itensQuantity: Int
        let price: Double
    }
    
    lazy var listItemView: ListItemView = {
        let view = ListItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ViewModel? = nil {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            
            self.listItemView.listNameLabel.text = viewModel.name
            self.listItemView.detailLabel.text = "\(viewModel.itensQuantity) itens"
            self.listItemView.priceLabel.text = "R$ \(String(format: "%.2f", viewModel.price))"
        }
    }
    
    static var identifier = String(describing: ListTableViewCell.self)
    static var height: CGFloat = 78
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
}

extension ListTableViewCell: ViewCode {
    func buildViewHierarchy() {
        self.contentView.addSubview(listItemView)
    }
    
    func setupConstraints() {
        self.listItemView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.listItemView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.listItemView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        self.listItemView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .init(white: 1, alpha: 0)
        selectionStyle = .none
    }
}
