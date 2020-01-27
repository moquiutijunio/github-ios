//  
//  HomePresenter.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa

protocol HomeRouterProtocol: AnyObject {
    
    func showUserRepositories(_ user: User)
}

final class HomePresenter: BasePresenter {
    
    private let interactor: HomeInteractorProtocol
    weak var router: HomeRouterProtocol?
    
    private var listResponse = BehaviorRelay<ListResponse<[UserDetailsCardViewModel]>>(value: .new)
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
    
    private func transformModelsToViewModels(users: [User]) -> [UserDetailsCardViewModel] {
        var viewModels = [UserDetailsCardViewModel]()
        viewModels.append(contentsOf: users.map { UserDetailsCardViewModel(user: $0) } )
        return viewModels
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
        
    var userRequestResponse: Driver<Void> {
        return interactor.userRequestResponse
            .do(onNext: { [weak self] (response) in
                guard let self = self else { return }
                
                switch response {
                case .loading:
                    self.listResponse.accept(.loading)
                    
                case .success(let users):
                    self.listResponse.accept(.success(self.transformModelsToViewModels(users: users)))
                    
                case .failure(let error):
                    self.listResponse.accept(.failure(error.localizedDescription))
                    
                case .new:
                    self.listResponse.accept(.new)
                }
            })
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
    }
    
    func searchBarTextDidChange(_ text: String) {
        interactor.queryDidChange(text)
    }
    
    func numberOfRowsInSection() -> Int {
        switch listResponse.value {
        case .success(let viewModels, _):
            return viewModels.count
            
        case .loading,
             .failure:
            return 1
            
        default:
            return 0
        }
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch listResponse.value {
        case .success(let viewModels, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsCardTableViewCell.reuseId, for: indexPath) as! UserDetailsCardTableViewCell
            cell.bindIn(viewModel: viewModels[indexPath.row])
            return cell
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseId, for: indexPath) as! LoadingTableViewCell
            return cell
            
        case .failure(let error):
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.reuseId, for: indexPath) as! ErrorTableViewCell
            cell.bindIn(error: error)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        if case .success(let viewModels, _) = listResponse.value {
            router?.showUserRepositories(viewModels[indexPath.row].user)
        }
    }
}
