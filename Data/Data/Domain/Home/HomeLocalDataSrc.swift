//
//  HomeLocalDataSrc.swift
//  Data
//
//  Created by prog_zidane on 2/9/21.
//

import Foundation
import RxSwift
import ModelsMapper

public class HomeLocalDataSrc {

    private let db: FollowerDao

    init(db: FollowerDao) {
        self.db = db
    }

    public func all() -> Single<[TwitterUser]?> {
        db.all().map { entities in
            entities.map { entity in
                TwitterUserMapper().map(entity)
            }
        }
    }

    public func save(users: [TwitterUser]?) -> Completable {
        let entities = ListMapper(UserEntityMapper()).map(users ?? [])
        return db.add(users: entities)
    }
}
