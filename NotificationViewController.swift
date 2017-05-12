//
//  NotificationViewController.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 5/3/17.
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
import SDWebImage


class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableNotification :   UITableView?
//    let dictNotify: NSDictionary!
    var arrDict = [DDNotifications]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Notification"
//        let backButton = UIBarButtonItem(barButtonSystemItem:.rewind, target: self, action: #selector(backButtonTapped))
//        navigationItem.leftBarButtonItems = [backButton]
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        
        //  For multilining cell as per text WS response
        tableNotification?.estimatedRowHeight = 100.0
        tableNotification?.rowHeight = UITableViewAutomaticDimension
        
        getNotificationList()
        
    }

    func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Table view datasource & delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
              return arrDict.count;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell
        
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            
            let notificationObj = arrDict[indexPath.row]
            
            cell?.lblTitle.text = notificationObj.message
            cell?.lbDetails.text = notificationObj.action
        let strImgUrl :String = (notificationObj.actor?.image)!
        
        let fileUrl = NSURL(string: strImgUrl as String)
        cell?.imgProduct.sd_setImage(with:fileUrl as URL!, placeholderImage: UIImage.init(named: "placeholder") )
        
        
       
        return cell!
    }
    
    func getNotificationList(){
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "Loading"
        
        var string1 = ""
        var string2 = ""
        
        let userDefaults : UserDefaults = UserDefaults.standard
        string1 = userDefaults.object(forKey: "accessTokenType") as! String + " "
        string2 = userDefaults.object(forKey: "accessToken") as! String
        userDefaults.synchronize()
        var accessToken: String
        
        accessToken = string1 + string2
        print("Final str:",accessToken)
        
        Alamofire.request("https://stagingapi.desidime.com/v3/notifications", method: .get, parameters: nil,
                          encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0",
                                                                    "Authorization": accessToken]).responseJSON {
            
            (response:DataResponse<Any>) in
            
            let responseCode  = response.response?.statusCode
            
            if responseCode == 200
            {
                if let JSON = response.result.value {
                    print("JSON1: \(JSON)")
                    let objNotify = DDNotificationModel.init(object: JSON)
                    print("JSON2: \(objNotify)")
                    
                    if let arrNotifyObj = objNotify.notifications {
                        self.arrDict  = arrNotifyObj
                    }
                    
                    DispatchQueue.main.async {
                        self.tableNotification? .reloadData()
                    }
                    
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                }
                
            }
            else  if responseCode == 401
            {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                // create the alert
                let alert = UIAlertController(title: "Desidime", message: "Invalid Login or password.", preferredStyle:
                    UIAlertControllerStyle.alert)
                
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
                let alert = UIAlertController(title: "Desidime", message: "Oops something went wrong!\nPlease try again.",
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: {
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                })
            }
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
