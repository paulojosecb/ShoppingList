//
//  ListView.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ListView: UIView {
    
    
    enum CustomError: String, Error {
        case invalidViewModel = "Invalid View Model"
    }
    
    struct ViewModel {
        
        struct Item {
            let name: String
            let description: String
            let price: Double
            let quantity: Int
        }
        
        let listName: String
        let listDescription: String
        let items: [ViewModel.Item]
        
    }
    
    private var viewModel: ListView.ViewModel {
        didSet {
            
        }
    }

    weak var tableViewDelegate: UITableViewDelegate?
    weak var tableViewDataSource: UITableViewDataSource?
    
    lazy var listHeaderView: ListHeaderView = {
        let view = ListHeaderView(viewModel: .init(name: self.viewModel.listName, description: self.viewModel.listDescription))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.separatorStyle = .none
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ItemTableViewCell.height
        tableView.backgroundColor = .init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return tableView
    }()
    
    lazy var floatButton: FloatButton = {
        let button = FloatButton(type: .add)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkoutBarView: CheckoutBarView = {
        let view = CheckoutBarView(viewModel: .init(total: 0.00, cartAction: nil))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: ViewModel, tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource) {
        self.viewModel = viewModel
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ viewModel: ViewModel) throws {
        
        if viewModel.listName == "" || viewModel.listDescription == "" {
            throw CustomError.invalidViewModel
        }
        
        self.viewModel = viewModel
    }

}

extension ListView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(listHeaderView)
        self.addSubview(tableView)
        self.addSubview(floatButton)
        self.addSubview(checkoutBarView)
    }
    
    func setupConstraints() {
        self.listHeaderView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        self.listHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.listHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.listHeaderView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.listHeaderView.bottomAnchor, constant: 16).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.checkoutBarView.heightAnchor.constraint(equalToConstant: CheckoutBarView.height).isActive = true
        self.checkoutBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.checkoutBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.checkoutBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.floatButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        self.floatButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.floatButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        self.floatButton.bottomAnchor.constraint(equalTo: self.checkoutBarView.topAnchor, constant: -16).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
    
}
