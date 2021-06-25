//
//  ListViewController.swift
//  ShoppingList
//
//  Created by Paulo José on 17/06/21.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel: IListViewModel
    
    init(viewModel: IListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.list.getItemsFromList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let itemOnList = self.viewModel.itensOnList[indexPath.row]
        
        cell.viewModel = .init(itemName: itemOnList.item.name,
                               itemDescription: "Marca",
                               quantity: itemOnList.quantity,
                               price: (itemOnList.unitPrice?.price ?? 0.0) * Double(itemOnList.quantity))
        
        return cell
    }

}


