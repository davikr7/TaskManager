//
//  Presenter.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import Foundation

protocol PresenterProtocol: AnyObject {
    var model: ModelProtocol! { get set }
    var view: RootViewControllerProtocol! { get set }
    var controllerTitle: String { get }
    func renameList(_ name: String)
    func removeList()
    
    var tableViewNumberOfRow: Int { get }
    func tableViewDataSource(_ indexPath: IndexPath) -> Task
    func selectList(_ indexPath: IndexPath)
    
    func collectionViewDataSource(_ indexPath: IndexPath) -> List
    var collectionViewNumberOfRow: Int { get }
    
    func addNewListWith(_ name: String)
    func loadData()
}

final class Presenter: PresenterProtocol {
    
    var model: ModelProtocol!
    let storage = DataStorage()
    weak var view: RootViewControllerProtocol!
    
    private var selectedList: Int = 0
    
    func loadData() {
        storage.getData { lists in
            if let lists = lists {
                model.lists = lists
                selectedList = storage.getSelectedIndexKey()
            } else {
                view.showAlert()
            }
        }
    }
    
    func saveData() {
        storage.saveData(model.lists) { success in
            if !success {
                view.showAlert()
            }
        }
    }
    
    var controllerTitle: String {
        model.lists[selectedList].name
    }
    
    func tableViewDataSource(_ indexPath: IndexPath) -> Task {
        model.lists[selectedList].tasks[indexPath.row]
    }
    
    var tableViewNumberOfRow: Int {
        model.lists[selectedList].taskCount
    }
    
    var collectionViewNumberOfRow: Int {
        model.listCount
    }
    
    func collectionViewDataSource(_ indexPath: IndexPath) -> List {
        model.lists[indexPath.item]
    }
    
    func selectList(_ indexPath: IndexPath) {
        selectedList = indexPath.item
        storage.saveSelectedListIndex(indexPath.item)
        view.reloadView()
    }
    
    func addNewListWith(_ name: String) {
        model.lists.append(.init(name: name, tasks: []))
        view.reloadView()
        saveData()
    }
    
    func renameList(_ name: String) {
        model.lists[selectedList].name = name
        view.reloadView()
        saveData()
    }
    
    func removeList() {
        model.lists.remove(at: selectedList)
        view.reloadView()
        saveData()
    }
    
}
