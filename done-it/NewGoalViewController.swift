import UIKit
import FirebaseDatabase
import Firebase

class NewGoalViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnBackClicked(_ sender: AnyObject) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
