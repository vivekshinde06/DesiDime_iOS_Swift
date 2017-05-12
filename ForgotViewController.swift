//
//  ForgotViewController.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 4/11/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import QuartzCore
import SystemConfiguration
import ReachabilitySwift

class ForgotViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        
//        let backButton = UIBarButtonItem(barButtonSystemItem:.cancel, target: self, action: #selector(backButtonTapped))
//        navigationItem.leftBarButtonItems = [backButton]
             self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        
        txtEmail?.borderStyle = .none
        txtEmail?.layer.backgroundColor = UIColor.white.cgColor
        txtEmail?.layer.masksToBounds = false
        txtEmail?.layer.shadowColor = UIColor.gray.cgColor
        txtEmail?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        txtEmail?.layer.shadowOpacity = 1.0
        txtEmail?.layer.shadowRadius = 0.0
        txtEmail?.leftViewMode = UITextFieldViewMode.always
        txtEmail?.leftView = UIImageView(image: UIImage(named: "Email"))
        
    }
    
    func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    @IBAction func sendClicked(sender:UIButton!){
        
        if Reachability.isConnectedToNetwork() == true
        {
            if txtEmail?.text == "" {
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Please enter email.", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            } else{
                
                let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                loadingNotification.mode = MBProgressHUDMode.indeterminate
                loadingNotification.labelText = "Loading"
                
                Alamofire.request("https://stagingapi.desidime.com/v3/forgot-password", method: .post, parameters: ["email": txtEmail?.text as Any], encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0"]).responseJSON { (response:DataResponse<Any>) in
                    
                    let responseCode  = response.response?.statusCode
                    
                    if responseCode == 200
                    {
                        // create the alert
                        let alert = UIAlertController(title: "Desidime", message: "New password link sent to your email address.", preferredStyle: UIAlertControllerStyle.alert)
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
                    else  if responseCode == 422
                    {
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                        // create the alert
                        let alert = UIAlertController(title: "Desidime", message: "Our records indicate that you had used Facebook or Google Authentication to signup. Please login again using the same method.", preferredStyle: UIAlertControllerStyle.alert)
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
