//
//  BaseWireFrame.swift
//  Presentation
//
//  Created by prog_zidane on 1/5/21.
//
import UIKit
import RxCocoa
import RxSwift
import RxRequester

open class BaseWireframe<T: ViewModel, Coordinator>: UIViewController {
    public var viewModel: T!
    public var coordinator: Coordinator!

    lazy public var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    public var hideNavigationBar: Bool = false {
        didSet {
            navigationController?.setNavigationBarHidden(self.hideNavigationBar, animated: false)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        bind(viewModel: viewModel)
        bindStates()
        hideNavigationBar = false
    }
    
    public init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(self.hideNavigationBar, animated: false)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hideNavigationBar {
            navigationController?.setNavigationBarHidden(!self.hideNavigationBar, animated: false)
        }
    }

    open func bind(viewModel: T) {
        fatalError("Please override bind function")
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func bindStates() {
        viewModel.displayError.subscribe { (text) in
            NotifiyMessage.shared.toast(toastMessage: text)
        }.disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe { [weak self] (isLoading) in
            guard let isLoading = isLoading.element else { return }
            self?.loadActivity(isLoading)
        }.disposed(by: disposeBag)
    }
    
    @objc open func onOpenProfile() {

    }
    
    @objc open func onOpenNotifications() {
        
    }
    
}

extension BaseWireframe {
    open func displayError(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseWireframe where T: ViewModel {
    open func bindLoadings(){
        print("Base view model is implemneted here..")
    }
}

extension BaseWireframe {
    // Storyboard setup
    static public func make(
        from storyboard: UIStoryboard.StoryboardType,
        with viewModel: T,
        coordinator: Coordinator
    ) -> Self<T> {
        let view = Self.instantiate(storyboard: storyboard)
        view.coordinator = coordinator
        view.viewModel = viewModel
        return view
    }
}

extension BaseWireframe: Presentable {
    public func showError(error: String) {
        NotifiyMessage.shared.toast(toastMessage: error)
    }

    public func showLoading() {
        self.loadActivity(true)
    }

    public func hideLoading() {
        self.loadActivity(false)
    }

    public func onHandleErrorFailed(error: Error) {
        NotifiyMessage.shared.toast(toastMessage: error.localizedDescription)
    }
}
