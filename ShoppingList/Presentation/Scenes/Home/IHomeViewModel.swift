//
//  IHomeViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 01/06/21.
//

import Foundation
import Promises

protocol IHomeViewModel {
    func fetchLists() -> Promise<[List]>
}
