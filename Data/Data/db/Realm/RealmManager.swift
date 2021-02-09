import Foundation
import RealmSwift
import Realm
import RxSwift
import Core

public var realmQueue: DispatchQueue = {
    DispatchQueue.main
}()

public class RealmManager {
    public init() {}

    func add(_ obj: Object) -> Completable {
        Completable.create { completable in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread
                            let object = obj.detached()
                            realm.add(object, update: .all)
                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func add(_ objects: [Object]) -> Completable {
        Completable.create { completable in
            autoreleasepool {
                realmQueue.async {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            // detach to keep the original object unmanaged to use it
                            // in any thread

                            for obj in objects {
                                let object = obj.detached()
                                realm.add(object, update: .all)
                            }

                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func delete(_ obj: Object) -> Completable {
        Completable.create { completable in
            realmQueue.async {
                autoreleasepool {
                    do {
                        let realm = try! Realm()
                        try realm.write {
                            realm.delete(obj)
                            completable(.completed)
                        }
                    } catch {
                        completable(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func object<T: Object, KeyType>(forPrimaryKey key: KeyType) -> Single<T> {
        Single<T>.create { single in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let obj = realm.object(ofType: T.self, forPrimaryKey: key)
                    guard let object: T = obj else {
                        let error = NSError(
                                domain: "Internal client error",
                                code: 100,
                                userInfo: [NSLocalizedDescriptionKey: "oops something went wrong"]
                        )
                        single(.error(error))
                        return
                    }
                    // detach to keep the object unmanaged to use it
                    // in any thread
                    let detached = object.detached()
                    single(.success(detached))
                }
            }
            return Disposables.create()
        }
    }

    func objects<T: Object>() -> Single<[T]> {
        Single<[T]>.create { single in
            realmQueue.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let list = realm.objects(T.self)
                    // detach to keep the object unmanaged to use it
                    // in any thread
                    let detached = list.detached
                    single(.success(detached))
                }
            }
            return Disposables.create()
        }
    }

    public func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
