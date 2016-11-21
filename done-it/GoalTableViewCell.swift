import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblGoalTitle: UILabel!
    @IBOutlet weak var lblTotalParticipants: UILabel!
    @IBOutlet weak var lblGoalPeriod: UILabel!
    @IBOutlet weak var lblCompletion: UILabel!
    @IBOutlet weak var gpcProgress: GoalProgressControl!
    
    func configureCell(goal: Goal) {
        lblGoalTitle.text = goal.title
        lblTotalParticipants.text = "\(goal.participantCount )"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        lblGoalPeriod.text = "\(formatter.string(from: goal.startDate)) - \(formatter.string(from: goal.endDate))"
        
        lblCompletion.text = "\(goal.progress )%"
        gpcProgress.totalCount = goal.unitsTotal 
        gpcProgress.progressCount = 0
        gpcProgress.moveProgress(progressIncrement: goal.unitsCompleted, animate: false)
    }

}
