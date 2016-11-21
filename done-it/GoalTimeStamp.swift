import Foundation

class GoalTimeStamp : Equatable {
    private var _goalId: Int!
    private var _participantId: Int!
    private var _timeStamp: Date!
    
    init(goalId: Int, participantId: Int, timeStamp: Date) {
        self.goalId = goalId
        self.participantId = participantId
        self.timeStamp = timeStamp
    }
    
    var goalId: Int {
        get {
            return _goalId
        }
        set {
            _goalId = newValue
        }
    }
    
    var participantId: Int {
        get {
            return _participantId
        }
        set {
            _participantId = newValue
        }
    }
    
    var timeStamp: Date {
        get {
            return _timeStamp
        }
        set {
            _timeStamp = newValue
        }
    }
}

func ==(lhs: GoalTimeStamp, rhs: GoalTimeStamp) -> Bool {
    return lhs.goalId == rhs.goalId
        && lhs.participantId == rhs.participantId
    && lhs.timeStamp.isEqualTo(date: rhs.timeStamp)
//        && lhs.timeStamp.isEqualTo(date: rhs.timeStamp, unitFlags: [.year, .month, .day, .hour])
}
