import Foundation

class Goal {
    private var _id: Int!
    private var _title: String!
    private var _participantIds: [Int]!
    private var _startDate: Date!
    private var _endDate: Date!
    private var _timeStamps: [GoalTimeStamp]!
    
    init(id: Int, title: String, startDate: Date, endDate: Date) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        _participantIds = [Int]()
        _timeStamps = [GoalTimeStamp]()
        addParticipantToGoal(participantId: 1)
        addParticipantToGoal(participantId: 2)
        addParticipantToGoal(participantId: 3)
        addParticipantToGoal(participantId: 4)
        addParticipantToGoal(participantId: 5)
        addParticipantToGoal(participantId: 6)
        
        for goalTimeStamp in MockGoalDao().getGoalTimeStamps(forGoalId: id) {
            if _participantIds.contains(goalTimeStamp.participantId) {
                _timeStamps.append(goalTimeStamp)
            }
        }
    }
    
    var id: Int {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var title: String {
        get {
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var startDate: Date {
        get {
            return _startDate
        }
        set {
            _startDate = newValue
        }
    }
    
    var endDate: Date {
        get {
            return _endDate
        }
        set {
            _endDate = newValue
        }
    }
    
    
    var participantCount: Int {
        get {
            return _participantIds.count
        }
    }
    
    var unitsTotal: Int {
        get {
            return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
            
        }
    }
    
    var unitsCompleted: Int {
        get {
            let completed = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day!
            if completed > unitsTotal {
                return unitsTotal
            } else {
                return completed
            }
        }
    }
    
    var progress: Int {
        get {
            return unitsCompleted * 100 / unitsTotal
        }
    }
    
    func addParticipantToGoal(participantId: Int) {
        if !_participantIds.contains(participantId) {
            _participantIds.append(participantId)
        }
    }
    
    func getParticipants() -> [GoalParticipant] {
        var list = [GoalParticipant]()
        for participant in MockGoalDao().getAllParticipants() {
            if _participantIds.contains(participant.id) {
                list.append(participant)
            }
        }
        return list
    }
    
    func getGoalTimeStamps() -> [GoalTimeStamp] {
        return _timeStamps
    }
    
    func completedParticipantsCount(forDate date: Date) -> Int {
        var count = 0
        for timeStamp in _timeStamps {
//            if timeStamp.timeStamp.isEqualTo(date: date, unitFlags: [.year, .month, .day, .hour]) {
            if timeStamp.timeStamp.isEqualTo(date: date) {
                count += 1
            }
        }
        return count
    }
    
    func getGoalHistory() -> [GoalHistoryItem] {
        return MockGoalDao().getGoalHistory(forGoal: self)
    }
    
    func toggleCompletion(forParticipant participantId: Int, onDate date: Date) {
        let timeStamp = GoalTimeStamp(goalId: id, participantId: participantId, timeStamp: date)
        let i = _timeStamps.index { (temp: GoalTimeStamp) -> Bool in
            return temp.goalId == timeStamp.goalId
                && temp.participantId == timeStamp.participantId
                && temp.timeStamp.isEqualTo(date: timeStamp.timeStamp)
        }
        if let index = i {
            _timeStamps.remove(at: index)
        } else {
            _timeStamps.append(timeStamp)
        }
    }
    
    func participantCompleted(forParticipant participantId: Int, onDate date: Date) -> Bool {
        let timeStamp = GoalTimeStamp(goalId: id, participantId: participantId, timeStamp: date)
        let i = _timeStamps.index { (temp: GoalTimeStamp) -> Bool in
            return temp.goalId == timeStamp.goalId
                && temp.participantId == timeStamp.participantId
                && temp.timeStamp.isEqualTo(date: timeStamp.timeStamp)
        }
        return i != nil
    }
}
