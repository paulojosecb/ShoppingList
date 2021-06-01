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
    
    var viewModel: ViewModel? = nil {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            
            self.listNameLabel.text = viewModel.name
            self.detailLabel.text = "\(viewModel.itensQuantity) itens"
            self.priceLabel.text = "R$ \(viewModel.price)"
        }
    }
    
    static var identifier = String(describing: ListTableViewCell.self)
    
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
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

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
    
    override func draw(_ rect: CGRect) {
        self.setupAdditionalConfiguration()
    }
    
    func setup() {
        
    }

}

extension ListTableViewCell: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(bulletPointView)
        self.contentView.addSubview(listNameLabel)
        self.addSubview(detailLabel)
        self.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        self.bulletPointView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.bulletPointView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        self.bulletPointView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        self.bulletPointView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.listNameLabel.leadingAnchor.constraint(equalTo: bulletPointView.trailingAnchor, constant: 8).isActive = true
        self.listNameLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        self.listNameLabel.heightAnchor.constraint(equalToConstant: self.listNameLabel.intrinsicContentSize.height).isActive = true
        self.listNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.detailLabel.leadingAnchor.constraint(equalTo: self.listNameLabel.leadingAnchor).isActive = true
        self.detailLabel.trailingAnchor.constraint(equalTo: self.listNameLabel.trailingAnchor).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: self.listNameLabel.bottomAnchor, constant: 8).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: self.detailLabel.intrinsicContentSize.height).isActive = true
        
        self.priceLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.listNameLabel.trailingAnchor, constant: 8).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: self.priceLabel.intrinsicContentSize.height).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
}
