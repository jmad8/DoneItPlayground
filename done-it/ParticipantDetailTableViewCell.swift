import UIKit

class ParticipantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblParticipantName: UILabel!
    @IBOutlet weak var lblDone: UILabel!
    
    func configureCell(participant: GoalParticipant, donedIt: Bool, animate: Bool) {
        
        if animate {
            UIView.animate(withDuration: 0.1, animations: {
                self.configureCell(participant: participant, donedIt: donedIt)
            })
        } else {
            configureCell(participant: participant, donedIt: donedIt)
        }
    }
    
    private func configureCell(participant: GoalParticipant, donedIt: Bool) {
        lblParticipantName.text = "\(participant.firstName) \(participant.lastName)"
        if donedIt {
            self.lblDone.alpha = 1.0
        } else {
            self.lblDone.alpha = 0.0
        }
    }

}
