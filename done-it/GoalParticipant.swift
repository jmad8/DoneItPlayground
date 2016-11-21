import Foundation

class GoalParticipant : Equatable {
    private var _id : Int!
    private var _firstName : String!
    private var _lastName : String!
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var id : Int {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var firstName : String {
        get {
            return _firstName
        }
        set {
            _firstName = newValue
        }
    }
    
    var lastName : String {
        get {
            return _lastName
        }
        set {
            _lastName = newValue
        }
    }
}

func ==(lhs: GoalParticipant, rhs: GoalParticipant) -> Bool {
    return lhs.id == rhs.id
        && lhs.firstName == rhs.firstName
        && lhs.lastName == rhs.lastName
}
