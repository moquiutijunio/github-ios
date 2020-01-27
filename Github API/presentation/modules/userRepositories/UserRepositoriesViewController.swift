//  
//  UserRepositoriesViewController.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa
import Kingfisher
import Cartography

protocol UserRepositoriesPresenterProtocol: BasePresenterProtocol {
    
    var title: String { get }
    var avatar: URL? { get }
    var userRepositoriesRequestResponse: Driver<Void> { get }
    var listResponseDidChange: Driver<ListResponse<[RepositoryDetailsViewModel]>> { get }
    
    func viewDidLoad()
    func avatarItemDidTap()
    func infinityScrollDidCalled()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

final class UserRepositoriesViewController: BaseTableViewController {
    
    private var presenter: UserRepositoriesPresenterProtocol {
        return basePresenter as! UserRepositoriesPresenterProtocol
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        presenter.viewDidLoad()
    }
    
    override func bind() {
        super.bind()
        
        presenter.listResponseDidChange
            .drive(onNext: { [unowned self] (response) in
                self.updateInfinityScroll(response)
            })
            .disposed(by: disposeBag)
        
        presenter.userRepositoriesRequestResponse
            .drive(onNext: { [tableView = tableView] (_) in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func applyLayout() {
        super.applyLayout()
        
        title = presenter.title
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("users", comment: ""), style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_avatar"), style: .done, target: self, action: #selector(avatarItemDidTap(tapGestureRecognizer:)))
        
        guard let avatar = presenter.avatar else { return }
        avatar.generateImage { [unowned self] (image) in
            self.addAvatarInButtomItem(image)
        }
    }
    
    private func addAvatarInButtomItem(_ image: UIImage?) {
        guard let image = image else { return }
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 14
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarItemDidTap(tapGestureRecognizer:)))

        imageView.addGestureRecognizer(tapGestureRecognizer)

        constrain(imageView) { (imageView) in
            imageView.width == 28
            imageView.height == 28
        }

        navigationItem.rightBarButtonItem?.customView = imageView
    }
    
    private func configureTableView() {
        
        tableView.addInfinityScrollRefreshView { [presenter = presenter] (_) in
            presenter.infinityScrollDidCalled()
        }
        
        tableView.register(UINib(nibName: RepositoryDetailsTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: RepositoryDetailsTableViewCell.reuseId)
    }
    
    @objc func avatarItemDidTap(tapGestureRecognizer: UITapGestureRecognizer) {
        presenter.avatarItemDidTap()
    }
}

// MARK: - InfinityScroll method
extension UserRepositoriesViewController {
    
    private func updateInfinityScroll(_ listResponse: ListResponse<[RepositoryDetailsViewModel]>) {
        tableView.ins_endInfinityScroll(withStoppingContentOffset: true)
        
        switch listResponse {
        case .new,
             .loading:
            tableView.ins_setInfinityScrollEnabled(false)
            
        case .success(let viewModels, let infinityScrollIsEnabled):
            if viewModels.isEmpty {
                tableView.ins_setInfinityScrollEnabled(infinityScrollIsEnabled ?? false)
            }else {
                tableView.ins_setInfinityScrollEnabled(infinityScrollIsEnabled ?? true)
            }
            
        case .failure:
            tableView.ins_setInfinityScrollEnabled(false)
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension UserRepositoriesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.cellForRowAt(tableView, indexPath: indexPath)
    }
}
