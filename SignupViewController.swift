//
//  SignupViewController.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 4/10/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import FacebookCore
import Alamofire
import SwiftyJSON
import FacebookLogin
import MBProgressHUD
import QuartzCore
import FBSDKCoreKit
import FBSDKLoginKit

class SignupViewController: UIViewController , GIDSignInUIDelegate , UITextFieldDelegate{
    
    
    @IBOutlet weak var btnRememberMe: UIButton?
    
    @IBOutlet weak var txtPassword: UITextField?
    @IBOutlet weak var txtConfirmPassword: UITextField?
    @IBOutlet weak var txtUsername: UITextField?
    @IBOutlet weak var txtPromotionCode: UITextField?
    @IBOutlet weak var txtEmail: UITextField?
    
    @IBOutlet weak var btnGoogle: UIButton?
    
    var strAlertStatus : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        btnRememberMe?.isSelected = true
        strAlertStatus = "true"
        
        GIDSignIn.sharedInstance().uiDelegate = self
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        // TODO(developer) Configure the sign-in button look/feel
        
        // ...
        
        btnGoogle?.backgroundColor = .clear
        btnGoogle?.layer.cornerRadius = 3
        btnGoogle?.layer.borderWidth = 1
        btnGoogle?.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        
        let backButton = UIBarButtonItem(barButtonSystemItem:.cancel, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [backButton]
        
   

        
        
        txtEmail?.borderStyle = .none
        txtEmail?.layer.backgroundColor = UIColor.white.cgColor
        txtEmail?.layer.masksToBounds = false
        txtEmail?.layer.shadowColor = UIColor.gray.cgColor
        txtEmail?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtEmail?.layer.shadowOpacity = 1.0
        txtEmail?.layer.shadowRadius = 0.0
        
        txtPassword?.borderStyle = .none
        txtPassword?.layer.backgroundColor = UIColor.white.cgColor
        txtPassword?.layer.masksToBounds = false
        txtPassword?.layer.shadowColor = UIColor.gray.cgColor
        txtPassword?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtPassword?.layer.shadowOpacity = 1.0
        txtPassword?.layer.shadowRadius = 0.0
        
        txtConfirmPassword?.borderStyle = .none
        txtConfirmPassword?.layer.backgroundColor = UIColor.white.cgColor
        txtConfirmPassword?.layer.masksToBounds = false
        txtConfirmPassword?.layer.shadowColor = UIColor.gray.cgColor
        txtConfirmPassword?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtConfirmPassword?.layer.shadowOpacity = 1.0
        txtConfirmPassword?.layer.shadowRadius = 0.0
        
        txtPromotionCode?.borderStyle = .none
        txtPromotionCode?.layer.backgroundColor = UIColor.white.cgColor
        txtPromotionCode?.layer.masksToBounds = false
        txtPromotionCode?.layer.shadowColor = UIColor.gray.cgColor
        txtPromotionCode?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtPromotionCode?.layer.shadowOpacity = 1.0
        txtPromotionCode?.layer.shadowRadius = 0.0
        
        txtUsername?.borderStyle = .none
        txtUsername?.layer.backgroundColor = UIColor.white.cgColor
        txtUsername?.layer.masksToBounds = false
        txtUsername?.layer.shadowColor = UIColor.gray.cgColor
        txtUsername?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtUsername?.layer.shadowOpacity = 1.0
        txtUsername?.layer.shadowRadius = 0.0
        
    }
    
    func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func googlePlusButtonTouchUpInside(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true
        {
            GIDSignIn.sharedInstance().signIn()
            
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.labelText = "Loading"
            
            // Uncomment to automatically sign in the user.
            GIDSignIn.sharedInstance().signInSilently()
            let userDefaults : UserDefaults = UserDefaults.standard
            
            var uid =  userDefaults.object(forKey: "googleId") as! String
            var email =  userDefaults.object(forKey: "googleemail") as! String
            var provider = "open_id"
            var device_number =  userDefaults.object(forKey: "DeviceId") as! String
            var social_access_token =  userDefaults.object(forKey: "googleIdToken") as! String
            var app_version =  userDefaults.object(forKey: "AppVersionNumber") as! String
            
            userDefaults.synchronize()
            
            Alamofire.request("https://stagingapi.desidime.com/v3.1/oauth/token", method: .post, parameters: ["client_id" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0" , "client_secret" : "0efd9ddb1688f4ee26fd711bc28d812d9da6bb0665ecc24c3e4737d16fd325c8" , "grant_type" : "password", "uid" : uid , "email" : email , "provider" : provider , "device_number" : device_number , "social_access_token" : social_access_token , "app_version" : app_version ], encoding: JSONEncoding.default, headers: [ "X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0"]).responseJSON {
                
                (response:DataResponse<Any>) in
                
                let responseCode  = response.response?.statusCode
                
                if responseCode == 201
                {
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    // create the alert
                    let alert = UIAlertController(title: "You are successfully registered", message: "Please click on the link that has just been sent to your email account to verify your complete registration process.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: {
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    })
                    
                }
                else  if responseCode == 401
                {
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    // create the alert
                    let alert = UIAlertController(title: "Desidime", message: "Invalid Login or password.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: {
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    })
                    
                }
                    
                else{
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    // create the alert
                    let alert = UIAlertController(title: "Desidime", message: "Oops something went wrong!\nPlease try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: {
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    })
                }
                
            }
        }
        else
        {
            print("Internet Connection not Available!")
            // create the alert
            let alert = UIAlertController(title: "Desidime", message: "Internet Connection not Available!", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    //MARK:Google SignIn Delegate
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            
            print("Response:",user.profile)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    @IBAction func fblogin(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    
                    if Reachability.isConnectedToNetwork() == true
                    {
                        GIDSignIn.sharedInstance().signIn()
                        
                        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                        loadingNotification.mode = MBProgressHUDMode.indeterminate
                        loadingNotification.labelText = "Loading"
                        
                        // Uncomment to automatically sign in the user.
                        GIDSignIn.sharedInstance().signInSilently()
                        let userDefaults : UserDefaults = UserDefaults.standard
                        
                        var bUserFacebookDict = result as! NSDictionary
                        let FB_USER_ID = bUserFacebookDict["id"]! as! String
                        var email =  bUserFacebookDict["name"]! as! String
                        var provider = "facebook"
                        var device_number =  userDefaults.object(forKey: "DeviceId") as! String
                        var social_access_token =  userDefaults.object(forKey: "googleIdToken") as! String
                        var app_version =  userDefaults.object(forKey: "AppVersionNumber") as! String
                        
                        userDefaults.synchronize()
                        
                        Alamofire.request("https://stagingapi.desidime.com/v3.1/oauth/token", method: .post, parameters: ["client_id" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0" , "client_secret" : "0efd9ddb1688f4ee26fd711bc28d812d9da6bb0665ecc24c3e4737d16fd325c8" , "grant_type" : "password", "uid" : FB_USER_ID , "email" : email , "provider" : provider , "device_number" : device_number , "social_access_token" : social_access_token , "app_version" : app_version ], encoding: JSONEncoding.default, headers: [ "X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0"]).responseJSON {
                            
                            (response:DataResponse<Any>) in
                            
                            let responseCode  = response.response?.statusCode
                            
                            if responseCode == 200
                            {
                                if let JSON = response.result.value {
                                    print("JSON: \(JSON)")
                                    let objLogin = RVLoginModel.init(object: JSON)
                                    
                                    let userDefaults : UserDefaults = UserDefaults.standard
                                    userDefaults.set(objLogin.accessToken, forKey: "accessToken")
                                    userDefaults.set(objLogin.refreshToken, forKey: "refreshToken")
                                    userDefaults.set(objLogin.tokenType, forKey: "accessTokenType")
                                    UserDefaults.standard.synchronize()
                                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                    // create the alert
                                    let alert = UIAlertController(title: "Desidime", message: "Account has been logged in successfully.", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: {
                                        if let navController = self.navigationController {
                                            navController.popViewController(animated: true)
                                        }
                                    })
                                }
                                
                            }
                            else  if responseCode == 401
                            {
                                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                // create the alert
                                let alert = UIAlertController(title: "Desidime", message: "Invalid Login or password.", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: {
                                    if let navController = self.navigationController {
                                        navController.popViewController(animated: true)
                                    }
                                })
                                
                            }
                                
                            else{
                                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                // create the alert
                                let alert = UIAlertController(title: "Desidime", message: "Oops something went wrong!\nPlease try again.", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: {
                                    if let navController = self.navigationController {
                                        navController.popViewController(animated: true)
                                    }
                                })
                            }
                            
                        }
                    }
                    else
                    {
                        print("Internet Connection not Available!")
                        // create the alert
                        let alert = UIAlertController(title: "Desidime", message: "Internet Connection not Available!", preferredStyle: UIAlertControllerStyle.alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            })
        }
    }
    
    @IBAction func signUpClicked(sender:UIButton!){
        
        if Reachability.isConnectedToNetwork() == true
        {
            
            if txtUsername?.text == "" {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter username.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else if txtEmail?.text == "" {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter email.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
                
            else if(isValidEmail(testStr: (txtEmail?.text)!)) {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter valid email.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else if txtPassword?.text == "" {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter password.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else if txtConfirmPassword?.text == "" {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter confirm password.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else if txtConfirmPassword?.text != txtPassword?.text!  {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter password and confirm password same.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
                
            else{
                
                let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                loadingNotification.mode = MBProgressHUDMode.indeterminate
                loadingNotification.labelText = "Loading"
                
                Alamofire.request("https://stagingapi.desidime.com/v3/users", method: .post, parameters: [ "login": txtUsername?.text as Any   , "password_confirmation" : txtConfirmPassword?.text as Any , "password" : txtPassword?.text as Any , "promocode_string" : txtPromotionCode?.text as Any , "email" : txtEmail?.text as Any , "daily_alert_email" : strAlertStatus], encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0"]).responseJSON { (response:DataResponse<Any>) in
                    
                    
                    let responseCode  = response.response?.statusCode
                    
                    if responseCode == 201
                    {
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                        // create the alert
                        let alert = UIAlertController(title: "You are successfully registered", message: "Please click on the link that has just been sent to your email account to verify your complete registration process.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: {
                            if let navController = self.navigationController {
                                navController.popViewController(animated: true)
                            }
                        })
                        
                    }
                    else  if responseCode == 401
                    {
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                        // create the alert
                        let alert = UIAlertController(title: "Desidime", message: "Invalid Login or password.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: {
                            if let navController = self.navigationController {
                                navController.popViewController(animated: true)
                            }
                        })
                        
                    }
                    else{
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                        // create the alert
                        let alert = UIAlertController(title: "Desidime", message: "Oops something went wrong!\nPlease try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: {
                            if let navController = self.navigationController {
                                navController.popViewController(animated: true)
                            }
                        })
                    }
                }
            }
        }
        else
        {
            print("Internet Connection not Available!")
            // create the alert
            let alert = UIAlertController(title: "Desidime", message: "Internet Connection not Available!", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func rememberMePressed(_ sender: Any) {
        btnRememberMe?.isSelected = !(btnRememberMe?.isSelected)! //toggle the text box
        
        strAlertStatus = "false"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
