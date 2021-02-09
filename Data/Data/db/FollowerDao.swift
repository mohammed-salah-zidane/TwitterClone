
import Foundation
import RealmSwift
import RxSwift

public class FollowerDao {
    private lazy var realm: RealmManager = { RealmManager() }()

    public func all() -> Single<[UserEntity]> {
        realm.objects()
    }

    public func add(user: UserEntity) -> Completable {
        realm.add(user)
    }

    public func add(users: [UserEntity]) -> Completable {
        realm.add(users)
    }

    public func delete(user: UserEntity) -> Completable {
        realm.delete(user)
    }

    public func follower(userId: String) -> Single<UserEntity> {
        realm.object(forPrimaryKey: userId)
    }
    
    public func deleteAll() {
        realm.deleteAll()
    }
}
