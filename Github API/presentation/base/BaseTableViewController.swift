//
//  BaseTableViewController.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import Cartography

class BaseTableViewController: BaseViewController {
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.alwaysBounceVertical = false
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: ErrorTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ErrorTableViewCell.reuseId)
        tableView.register(UINib(nibName: LoadingTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: LoadingTableViewCell.reuseId)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        
        addTableView()
    }
    
    private func addTableView() {
        
        view.addSubview(tableView)
        constrain(view, tableView, car_topLayoutGuide, car_bottomLayoutGuide) { (container, tableView, topGuide, bottomGuide) in
            tableView.left == container.left
            tableView.right == container.right
            tableView.top == container.safeAreaLayoutGuide.top
            tableView.bottom == container.safeAreaLayoutGuide.bottom
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
