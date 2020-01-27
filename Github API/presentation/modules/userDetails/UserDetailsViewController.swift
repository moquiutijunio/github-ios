//  
//  UserDetailsViewController.swift
//  Github API
//
//  Created by Junio Moquiuti on 26/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa
import Cartography

protocol UserDetailsPresenterProtocol: BasePresenterProtocol {
    
    var title: String { get }
    var viewModel: UserDetailsViewModel { get }
    var userRequestResponse: Driver<Void> { get }
}

final class UserDetailsViewController: BaseViewController {
    
    private var presenter: UserDetailsPresenterProtocol {
        return basePresenter as! UserDetailsPresenterProtocol
    }
    
    private lazy var userDetailsView = UserDetailsView.instantiateFromNib(viewModel: presenter.viewModel)
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func bind() {
        super.bind()
        
        presenter.userRequestResponse
            .drive()
            .disposed(by: disposeBag)
    }
    
    override public func applyLayout() {
        super.applyLayout()
        
        title = presenter.title
    }
}

// MARK: - SetupViews
extension UserDetailsViewController {
    
    private func setupViews() {
        
        view.addSubview(userDetailsView)
        constrain(view, userDetailsView) { (container, view) in
            view.left == container.left
            view.right == container.right
            view.top == container.safeAreaLayoutGuide.top
            view.bottom == container.safeAreaLayoutGuide.bottom
        }
    }
}
