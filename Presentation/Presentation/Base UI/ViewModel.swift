//
//  ViewModel.swift
//  Presentation
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation
import Data
import RxSwift
import RxCocoa

public protocol ViewModel: class {
    var dataManager: DataManager { get set }
    var isLoading: PublishSubject<Bool> { get set }
    var displayError: PublishSubject<String> { get set }
    var disposeBag: DisposeBag { get set }
    func handleError(error: Error)
}

public extension ViewModel {
    func handleError(error: Error) {
        self.isLoading.onNext(false)
        if let error = error as? NetworkError {
            self.displayError.onNext(error.errorDescription ?? "")
            return
        }
        
        if let networkError = NetworkError.init(error).errorDescription {
            self.displayError.onNext(networkError)
            return
        }
    }
}
