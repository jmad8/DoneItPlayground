    import UIKit

class GoalDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var progressControl: GoalProgressControl!
    @IBOutlet weak var lblGoalTitle: UILabel!
    @IBOutlet weak var btnDoneIt: UIButton!
    @IBOutlet weak var cvHistory: UICollectionView!
    @IBOutlet weak var lblCurrentItem: UILabel!
    @IBOutlet weak var lblCompletion: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tvParticipants: UITableView!
    
    var goal: Goal?
    var history: [GoalHistoryItem]?
    var currentItem: GoalHistoryItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvHistory.delegate = self
        cvHistory.dataSource = self
        
        tvParticipants.delegate = self
        tvParticipants.dataSource = self
        
        lblGoalTitle.text = goal?.title
        
        history = goal?.getGoalHistory()
        
        cvHistory.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
        
        currentItem = history?.first
        if let totalCount = goal?.participantCount {
            progressControl.totalCount = totalCount
        }
        populateCurrentItem()
    }
    
    @IBAction func btnBackClicked(_ sender: AnyObject) {
        let _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func btnDoneItClicked(_ sender: AnyObject) {
        if let goal = goal, let currentItem = currentItem {
            
            goal.toggleCompletion(forParticipant: 1, onDate: currentItem.date)
            
            configureCurrentItem(currentItemChanged: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = cvHistory.dequeueReusableCell(withReuseIdentifier: "GoalHistoryCollectionViewCell", for: indexPath) as? GoalHistoryCollectionViewCell, let goal = goal, let history = history {
            cell.configureCell(goal: goal, historyItem: history[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = history?.count {
            return count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = history?[indexPath.row] {
            if let currentItem = currentItem, currentItem == selectedItem {
                return
            }
            currentItem = selectedItem
            populateCurrentItem()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let goal = goal {
            return goal.participantCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tvParticipants.dequeueReusableCell(withIdentifier: "ParticipantDetailTableViewCell", for: indexPath) as? ParticipantDetailTableViewCell, let goal = goal {
            let participant = goal.getParticipants()[indexPath.row]
            var donedIt = false
            if let currentItem = currentItem {
                donedIt = goal.participantCompleted(forParticipant: participant.id, onDate: currentItem.date)
            }
            cell.configureCell(participant: participant, donedIt: donedIt, animate: false)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func populateCurrentItem() {
        configureCurrentItem(currentItemChanged: true)
    }
    
    func configureCurrentItem(currentItemChanged: Bool) {
        
        guard let currentItem = currentItem, let goal = goal else {
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
                self.lblCompletion.alpha = 0.0
                if currentItemChanged {
                    self.lblCurrentItem.alpha = 0.0
                }
            }, completion: { (finished: Bool) in
                
                let progressDiff = goal.completedParticipantsCount(forDate: currentItem.date) - self.progressControl.progressCount
                if progressDiff != 0 {
                    self.progressControl.moveProgress(progressIncrement: progressDiff, animate: true)
                }
                
                if let index = self.history?.index(of: currentItem) {
                    let indexPath = IndexPath(row: index, section: 0)
                    if let cell = self.cvHistory.cellForItem(at: indexPath) as? GoalHistoryCollectionViewCell {
                        let progressDiff = goal.completedParticipantsCount(forDate: currentItem.date) - cell.progressControl.progressCount
                        if progressDiff != 0 {
                            cell.progressControl.moveProgress(progressIncrement: progressDiff, animate: true)
                        }
                    }
                }
                
                for cell in self.tvParticipants.visibleCells {
                    if let cell = cell as? ParticipantDetailTableViewCell, let index = self.tvParticipants.visibleCells.index(of: cell) {
                        let participant = goal.getParticipants()[index]
                        let donedIt = goal.participantCompleted(forParticipant: participant.id, onDate: currentItem.date)
                        cell.configureCell(participant: participant, donedIt: donedIt, animate: true)
                    }
                }
                
                self.configureBtnDoneIt(item: currentItem)
                self.configureLblCompletion(item: currentItem)
                if currentItemChanged {
                    self.configureLblCurrentItem(item: currentItem)
                }
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.lblCompletion.alpha = 1.0
                    if currentItemChanged {
                        self.lblCurrentItem.alpha = 1.0
                    }
                })
        })
    }
    
    func configureBtnDoneIt(item: GoalHistoryItem) {
        guard let goal = goal else {
            return
        }
        if goal.participantCompleted(forParticipant: 1, onDate: item.date) {
            btnDoneIt.backgroundColor = UIColor.themeE()
        } else {
            btnDoneIt.backgroundColor = UIColor.themeA()
        }
    }
    
    func configureLblCompletion(item: GoalHistoryItem) {
        guard let goal = goal else {
            lblCompletion.text = "0% Completed"
            return
        }
        var percentage = (goal.completedParticipantsCount(forDate: item.date) * 100) / goal.participantCount
        if percentage > 100 {
            percentage = 100
        }
        lblCompletion.text = "\(percentage)% Completed"
    }
    
    func configureLblCurrentItem(item: GoalHistoryItem) {
        if item.date.isEqualTo(date: Date()) {
            lblCurrentItem.text = "Today"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            lblCurrentItem.text = formatter.string(from: item.date)
        }
    }
}
