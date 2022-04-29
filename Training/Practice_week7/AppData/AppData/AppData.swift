import Foundation

class AppData {
    
    public static let shared = AppData()
    
    private var dict: [String: Any] = [:]
        
    private init(){ }

    let lock = NSLock()
    public func set(value: Any, key: String) {
        lock.lock()
        dict[key] = value
        lock.unlock()
    }

    public func object(key: String) -> Any? {
        dict[key]
    }

    public func reset(){
        dict.removeAll()
    }
}
