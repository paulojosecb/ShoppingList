//
//  ListView.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ListView: UIView {

    let tableViewDelegate: UITableViewDelegate
    let tableViewDataSource: UITableViewDataSource
    
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

extension ListView: ViewCode {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
}
