//
//  BaseViewController.swift
//  Github API
//
//  Created by Junio Moquiuti on 25/01/20.
//  Copyright © 2020 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    internal var disposeBag: DisposeBag!
    internal let basePresenter: BasePresenterProtocol
    
    init(presenter: BasePresenterProtocol) {
        self.basePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyLayout()
        bind()
    }
    
    internal func bind() {
        disposeBag = DisposeBag()
        
    }
    
    internal func applyLayout() {
        view.backgroundColor = .white
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
