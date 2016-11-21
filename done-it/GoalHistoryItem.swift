import Foundation

class GoalHistoryItem : Equatable {
    
    private var _date: Date
    
    init(date: Date) {
        _date = date
    }
    
    var date: Date {
        get {
            return _date
        }
        set {
            _date = newValue
        }
    }
}

func ==(lhs: GoalHistoryItem, rhs: GoalHistoryItem) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
