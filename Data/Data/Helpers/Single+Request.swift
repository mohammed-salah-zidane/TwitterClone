//
//  Created by prog_zidane on 12/13/20.
//

import Foundation
import Moya
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    func mapItem<T: Decodable>() -> Single<T> {
        map(T.self, failsOnEmptyData: false)
    }

    func mapList<T: Decodable>() -> Single<[T]> {
        map([T].self, failsOnEmptyData: false)
    }
}
