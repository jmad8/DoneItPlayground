import UIKit

class InvitedParticipantTableViewCell: UITableViewCell {

    @IBOutlet weak var lblParticipantName: UILabel!
    @IBOutlet weak var lblInvited: UILabel!
    
    func configureCell(participant: GoalParticipant, invited: Bool) {
        lblParticipantName.text = "\(participant.firstName) \(participant.lastName)"
        lblInvited.text = invited ? "✅" : "❌"
    }
    
    func toggleInvited() -> Bool {
        if let text = lblInvited.text, text == "✅" {
            lblInvited.text = "❌"
            return false
        } else {
            lblInvited.text = "✅"
            return true
        }
    }
}
