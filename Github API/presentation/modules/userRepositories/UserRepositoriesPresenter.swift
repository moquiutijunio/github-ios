//  
//  UserRepositoriesPresenter.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxCocoa

protocol UserRepositoriesRouterProtocol: AnyObject {
    
    func showUserDetails(_ user: User)
}

final class UserRepositoriesPresenter: BasePresenter {
    
    private let interactor: UserRepositoriesInteractorProtocol
    weak var router: UserRepositoriesRouterProtocol?
    
    private var viewModels = [RepositoryDetailsViewModel]()
    private var listResponse = BehaviorRelay<ListResponse<[RepositoryDetailsViewModel]>>(value: .new)
    
    init(interactor: UserRepositoriesInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
    
    private func transformModelsToViewModels(repositories: [Repository]) -> [RepositoryDetailsViewModel] {
        viewModels.append(contentsOf: repositories.map { RepositoryDetailsViewModel(repository: $0) } )
        return viewModels
    }
}

// MARK: - UserRepositoriesPresenterProtocol
extension UserRepositoriesPresenter: UserRepositoriesPresenterProtocol {
    
    var title: String {
        let localizedString = NSLocalizedString("user.repository", comment: "")
        return String(format: localizedString, interactor.user.name ?? interactor.user.login)
    }
    
    var avatar: URL? {
        return interactor.user.avatar
    }
    
    var listResponseDidChange: Driver<ListResponse<[RepositoryDetailsViewModel]>> {
        return listResponse
            .asDriver()
    }
    
    var userRepositoriesRequestResponse: Driver<Void> {
        return interactor.userRepositoriesRequestResponse
            .do(onNext: { [weak self] (response) in
                guard let self = self else { return }
                
                switch response {
                case .loading:
                    guard self.viewModels.isEmpty else { return }
                    self.listResponse.accept(.loading)
                    
                case .success(let repositories):
                    self.listResponse.accept(.success(self.transformModelsToViewModels(repositories: repositories),
                                                      infinityScrollIsEnabled: repositories.isEmpty ? false : true))
                    
                case .failure(let error):
                    self.listResponse.accept(.failure(error.localizedDescription))
                    
                default:
                    break
                }
            })
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
    }
    
    func viewDidLoad() {
        interactor.requestRepositories()
    }
    
    func avatarItemDidTap() {
        router?.showUserDetails(interactor.user)
    }
    
    func infinityScrollDidCalled() {
        interactor.requestMoreRepositories()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryDetailsTableViewCell.reuseId, for: indexPath) as! RepositoryDetailsTableViewCell
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
}
