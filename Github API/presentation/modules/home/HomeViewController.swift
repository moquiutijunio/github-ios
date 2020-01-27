//  
//  HomeViewController.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa

protocol HomePresenterProtocol: BasePresenterProtocol {
            
    var userRequestResponse: Driver<Void> { get }
    
    func searchBarTextDidChange(_ text: String)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath)
}

final class HomeViewController: BaseTableViewController {
    
    private var presenter: HomePresenterProtocol {
        return basePresenter as! HomePresenterProtocol
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("search.for.users", comment: "")
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textFieldInsideUISearchBar?.textColor = .black
        navigationItem.titleView = searchBar
        return searchBar
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    override func bind() {
        super.bind()
        
        presenter.userRequestResponse
            .drive(onNext: { [tableView = tableView] (_) in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func registerTableView() {
        
        tableView.register(UINib(nibName: UserDetailsCardTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: UserDetailsCardTableViewCell.reuseId)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(searchText)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.cellForRowAt(tableView, indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
