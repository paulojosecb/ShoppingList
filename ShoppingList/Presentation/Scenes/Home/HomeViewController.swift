//
//  HomeViewController.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = HomeView(tableViewDelegate: self, tableViewDataSource: self)
        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
