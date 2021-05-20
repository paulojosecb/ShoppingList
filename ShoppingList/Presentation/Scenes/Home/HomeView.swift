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
        
    }
}
