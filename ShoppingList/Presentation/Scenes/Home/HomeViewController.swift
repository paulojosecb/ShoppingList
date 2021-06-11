//
//  HomeViewController.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    var customView: HomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView = HomeView(tableViewDelegate: self, tableViewDataSource: self)
        self.view = customView
        // Do any additional setup after loading the view.
        
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Bem-vindo, Paulo"
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(openAddList)),
            UIBarButtonItem(title: "Itens", style: .plain, target: self, action: #selector(openItensViewController))
        ]
        
    }
    
    private func fetchLists() {
        self.viewModel.fetchLists()
            .then { lists in
                self.customView?.tableView.reloadData()
            }
            .catch { _ in
                
            }
    }
    
    private func createList(with name: String) {
        self.viewModel.createListWith(name: name)
            .then { (list) in
                self.fetchLists()
            }
            .catch { _ in
                
            }
    }
    
    @objc func openItensViewController() {
        
    }
    
    @objc func openAddList() {
        var alertTextField: UITextField? = nil
        
        let alertController = UIAlertController(title: "Criar nova lista", message: "Como desejar chamar sua nova lista de compras?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            alertTextField = textField
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Criar", style: .default, handler: { (action) in
            
            guard let listName = alertTextField?.text,
                  listName != "" else {
                return
            }
            
            self.createList(with: listName)
    
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.lists.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let list = self.viewModel.lists[indexPath.row]
        
        cell.viewModel = .init(name: list.name,
                               itensQuantity: list.getItemsFromList().count,
                               price: list.total)
        
        return cell
    }
    

}
