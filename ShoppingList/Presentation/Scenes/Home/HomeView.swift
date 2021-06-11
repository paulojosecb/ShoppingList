//
//  HomeView.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import UIKit

class HomeView: UIView {
    
    let tableViewDelegate: UITableViewDelegate
    let tableViewDataSource: UITableViewDataSource
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.separatorStyle = .none
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.backgroundColor = .init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return tableView
    }()

    init(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: ViewCode {
    func buildViewHierarchy() {
        self.backgroundColor = .red
        addSubview(tableView)
    }
    
    func setupConstraints() {
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
}
