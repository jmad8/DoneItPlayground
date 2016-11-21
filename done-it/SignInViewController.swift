import UIKit
import FirebaseAuth
import FBSDKLoginKit
import Firebase

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var btnLogin: CustomButton!
    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        btnGoogleLogin.colorScheme = GIDSignInButtonColorScheme.light
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 96)
        view.addSubview(loginButton)
    }
    
    @IBAction func createClicked(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: tbEmail.text!, password: tbPassword.text!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        //do nothing???
    }
}
