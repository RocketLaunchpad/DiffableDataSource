import Foundation

protocol MutableType {
    associatedtype PropertyType
    var property: PropertyType { get set }
}

struct AnyMutableType<PropertyType>: MutableType {

    private let _getProperty: () -> PropertyType

    private let _setProperty: (PropertyType) -> Void

    init<T>(_ wrapped: T) where T: MutableType, T.PropertyType == PropertyType {
        _getProperty = {
            return wrapped.property
        }

        _setProperty = {
            wrapped.property = $0
        }
    }

    var property: PropertyType {
        get {
            return _getProperty()
        }

        set {
            _setProperty(newValue)
        }
    }
}
