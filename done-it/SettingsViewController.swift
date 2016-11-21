import UIKit
import FirebaseAuth
import FBSDKLoginKit

class SettingsViewController: UIViewController {
    
    @IBAction func btnLogOutClicked(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        FBSDKLoginManager().logOut()
        performSegue(withIdentifier: "showSignInSegue", sender: nil)
        
    }
}
