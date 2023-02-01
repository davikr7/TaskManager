//
//  RootViewController.swift
//  TaskManager
//
//  Created by grandmaster on 1.2.23..
//

import UIKit

protocol RootViewControllerProtocol: AnyObject {
    var presenter: PresenterProtocol! { get set }
    
    func reloadView()
    func showAlert()
}

final class RootViewController: UIViewController, RootViewControllerProtocol {
    
    var presenter: PresenterProtocol!
    
    internal lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
        return collectionView
    }()
    
    private lazy var taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = presenter.controllerTitle
        view.addSubview(listCollectionView)
        view.addSubview(taskTableView)
        configureNavigationBar()
    }
    
    private func addConstraints() {
        addConstraintsToListCV()
        addConstraintsToTaskTV()
        
    }
    
    private func addConstraintsToListCV() {
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.padding),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.padding),
            listCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func addConstraintsToTaskTV() {
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskTableView.topAnchor.constraint(equalTo: listCollectionView.bottomAnchor),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constant.imageAddList),
            style: .done,
            target: self,
            action: #selector(addListHandler))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constant.imageEditList), style: .done, target: self, action: #selector(editListHandler))
    }
    
    @objc private func editListHandler() {
        let alert = UIAlertController(title: "Edit list",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let editName = UIAlertAction(title: "Rename list", style: .default) { [weak self] _ in
            self?.showEditAlert(alertTitle: "Input new list name",
                                actionTitle: "Rename",
                                placeholder: "Name") { [weak self] name in
                self?.presenter.renameList(name)
            }
        }
        
        let removeList = UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.presenter.removeList()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(editName)
        alert.addAction(removeList)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc private func addListHandler() {
        showEditAlert(alertTitle: "Add new List", actionTitle: "Add", placeholder: "Input list name") { [weak self] name in
            self?.presenter.addNewListWith(name)
        }
    }
    
    private func showEditAlert(alertTitle: String? = nil,
                               actionTitle: String? = nil,
                               placeholder: String? = nil,
                               handler: @escaping (String)-> Void) {
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: actionTitle, style: .default) { action in
            action.isEnabled = false
            let textField = alert.textFields?.first as? UITextField
            if let name = textField?.text {
                handler(name)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func reloadView() {
        taskTableView.reloadData()
        listCollectionView.reloadData()
        title = presenter.controllerTitle
    }
    
    func showAlert() {
        showErrorAlert()
    }
}

//MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableViewNumberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.populateData(presenter.tableViewDataSource(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.tableViewCellHeight
    }
    
    
}

//MARK: - UITableViewDelegate

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDataSource

extension RootViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionViewNumberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.populateCell(presenter.collectionViewDataSource(indexPath))
        cell.backgroundColor = .gray
        return cell
        
    }
    
}

//MARK: - UICollectionViewDelegate

extension RootViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectList(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 40)
    }
    
}


