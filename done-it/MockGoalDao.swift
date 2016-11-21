import Foundation

class MockGoalDao {

    func GetGoals() -> [Goal] {
        var goals = [Goal]()
        
        let date = Date()
        
        goals.append(Goal(id: 1, title: "Scripture Study", startDate: date.add(days: -80), endDate: date.add(days: 10)))
        goals.append(Goal(id: 2, title: "P90X3", startDate: date.add(days: -10), endDate: date.add(days: 80)))
        goals.append(Goal(id: 3, title: "Early to Rise...", startDate: date.add(days: 10), endDate: date.add(days: 1000)))
        
        return goals
    }
    
    func getGoalHistory(forGoal goal: Goal) -> [GoalHistoryItem] {
        var history = [GoalHistoryItem]()
        
        let today = Date()
        var date = goal.endDate.isGreaterThan(date: today) ? today : goal.endDate
        while (date.isGreaterThan(date: goal.startDate) && !date.isEqualTo(date: goal.startDate)) {
            history.append(GoalHistoryItem(date: date))
            date = date.add(days: -1)
        }
        
        return history
    }
    
    func getGoalTimeStamps(forGoalId goalId: Int) -> [GoalTimeStamp] {
        var list = [GoalTimeStamp]()
        
        let date = Date()
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 1, timeStamp: date))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 1, timeStamp: date.add(days: -3)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 1, timeStamp: date.add(days: -4)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 1, timeStamp: date.add(days: -7)))
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 2, timeStamp: date))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 2, timeStamp: date.add(days: -1)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 2, timeStamp: date.add(days: -5)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 2, timeStamp: date.add(days: -13)))
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 3, timeStamp: date))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 3, timeStamp: date.add(days: -4)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 3, timeStamp: date.add(days: -9)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 3, timeStamp: date.add(days: -10)))
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 4, timeStamp: date))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 4, timeStamp: date.add(days: -2)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 4, timeStamp: date.add(days: -6)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 4, timeStamp: date.add(days: -8)))
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 5, timeStamp: date.add(days: -1)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 5, timeStamp: date.add(days: -2)))
        list.append(GoalTimeStamp(goalId: goalId, participantId: 5, timeStamp: date.add(days: -9)))
        
        list.append(GoalTimeStamp(goalId: goalId, participantId: 6, timeStamp: date.add(days: -5)))
        
        return list
    }
    
    private static var _allParticipants: [GoalParticipant]?
    
    func getAllParticipants() -> [GoalParticipant] {
        if let allParticipants = MockGoalDao._allParticipants {
            return allParticipants
        } else {
            MockGoalDao._allParticipants = [
                GoalParticipant(id: 1, firstName: "Justin", lastName: "Madsen"),
                GoalParticipant(id: 2, firstName: "Mike", lastName: "Madsen"),
                GoalParticipant(id: 3, firstName: "Jason", lastName: "Madsen"),
                GoalParticipant(id: 4, firstName: "Jared", lastName: "Madsen"),
                GoalParticipant(id: 5, firstName: "Jeff", lastName: "Madsen"),
                GoalParticipant(id: 6, firstName: "Jake", lastName: "Madsen")
            ]
            return getAllParticipants()
        }
        
    }
}
