
import Realm
import RealmSwift

public protocol RealmListDetachable {
    func detached() -> Self
}

extension List: RealmListDetachable where Element: Object {
    public func detached() -> List<Element> {
        if isEmpty { return List<Element>() }
        let detached = self.detached
        let result = List<Element>()
        result.append(objectsIn: detached)
        return result
    }
}

public extension Object {
    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            if let detachable = value as? Object {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else if let list = value as? RealmListDetachable {
                detached.setValue(list.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

public extension Sequence where Iterator.Element: Object {
    var detached: [Element] {
        // sometimes objc may return a nil object
        self.filter({ $0 != nil }).map({ $0.detached() })
    }
}
