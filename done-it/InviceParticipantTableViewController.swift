import UIKit

class InviceParticipantTableViewController: UITableViewController {
    var participants : [GoalParticipant]?
    var invitedParticipants : [GoalParticipant]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        participants = [
            GoalParticipant(id: 0, firstName: "Justin", lastName: "Madsen"),
            GoalParticipant(id: 1, firstName: "Mike", lastName: "Madsen"),
            GoalParticipant(id: 2, firstName: "Jason", lastName: "Madsen"),
            GoalParticipant(id: 3, firstName: "Jared", lastName: "Madsen"),
            GoalParticipant(id: 4, firstName: "Jeff", lastName: "Madsen"),
            GoalParticipant(id: 5, firstName: "Jake", lastName: "Madsen")
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (participants?.count) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InvitedParticipantTableViewCell", for: indexPath) as? InvitedParticipantTableViewCell {
            if  let participant = participants?[indexPath.row] {
                cell.configureCell(participant: participant, invited: false)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? InvitedParticipantTableViewCell {
            let invited = cell.toggleInvited()
            
            if var invitedParticipants = invitedParticipants, let participants = participants {
                let participant = participants[indexPath.row]
                if invited {
                    invitedParticipants.append(participant)
                } else if let index = invitedParticipants.index(of: participant) {
                    invitedParticipants.remove(at: index)
                }
            }
        }
    }
}
