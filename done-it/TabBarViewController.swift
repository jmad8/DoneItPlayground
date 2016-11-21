import UIKit
import FirebaseDatabase

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = UIColor.themeE()
//        UITabBar.appearance().unselectedItemTintColor = UIColor.white()
//        UITabBar.appearance().barTintColor = UIColor.themeA()
        //configureDatabase()
    }
    
    
    func configureDatabase(){
        let ref = FIRDatabase.database().reference()
        print(ref.key)
        let key = ref.child("goals").childByAutoId()
        key.setValue("testing")
        print(key)
    }

}
