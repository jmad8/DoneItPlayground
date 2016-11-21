import UIKit

class GoalHistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var progressControl: GoalProgressControl!
    @IBOutlet weak var lblDescription: UILabel!
    
    func configureCell(goal: Goal, historyItem: GoalHistoryItem) {
        
        progressControl.totalCount = goal.participantCount
        print(goal.participantCount)
        progressControl.progressCount = 0
        let increment = goal.completedParticipantsCount(forDate: historyItem.date)
        progressControl.moveProgress(progressIncrement: increment, animate: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        lblDescription.text = formatter.string(from: historyItem.date)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.themeA().cgColor
                self.layer.borderWidth = 5
                self.layer.cornerRadius = 5
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
}
