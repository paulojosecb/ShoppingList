//
//  ListViewController.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let presenter: IListPresenter
    var customView: ListView?
    
    init(presenter: IListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listViewModel = ListView.ViewModel(listName: presenter.list.name,
                                               listDescription: "last edited 15/03/2021",
                                               items: [])
        customView = ListView(viewModel: listViewModel, tableViewDelegate: self, tableViewDataSource: self)
        self.view = customView
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Mais", style: .plain, target: self, action: #selector(openActionSheet))
        ]
        
    }
    
    @objc func openActionSheet() {
        let alertController = self.buildMoreAlertController()
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Lista" : "Carrinho"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ?
            self.presenter.list.getItemsFromList().count :
            self.presenter.list.getItemsFromCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let itemOnList = self.presenter.list.getItemsFromList()[indexPath.row]
        
        cell.viewModel = .init(itemName: itemOnList.item.name,
                               itemDescription: "Marca",
                               quantity: itemOnList.quantity,
                               price: (itemOnList.unitPrice?.price ?? 0.0) * Double(itemOnList.quantity))
        
        return cell
    }
    
    private func buildMoreAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: self.presenter.list.name,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let saveAsTemplateAlertAction = UIAlertAction(title: "Salvar como template",
                                                 style: .default, handler: nil)
        let deleteAlertAction = UIAlertAction(title: "Deletar",
                                   style: .destructive, handler: nil)
        let cancelAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(saveAsTemplateAlertAction)
        alertController.addAction(deleteAlertAction)
        alertController.addAction(cancelAlertAction)
        
        return alertController
    }

}


