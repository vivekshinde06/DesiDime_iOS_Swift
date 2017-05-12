
//
//  HomeViewController.swift
//  Desidime_V_1.0
//
//  Created by PCPL 41 on 4/3/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SDWebImage

class HomeViewController: UIViewController, UITextFieldDelegate ,UITabBarDelegate, UITabBarControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var buttonTop : UIButton?
    @IBOutlet weak var buttonPopular :    UIButton?
    @IBOutlet weak var buttonFeatured  :    UIButton?
    
    @IBOutlet weak var buttonDiscussion :    UIButton?
    @IBOutlet weak var buttonForum  :    UIButton?
    
    @IBOutlet weak var viewBottomHeader :        UIView?
    
    @IBOutlet weak var tableTransaction :   UITableView?
    @IBOutlet weak var tableDiscussion :   UITableView?
    
    @IBOutlet weak var viewTransaction :    UIView?
    @IBOutlet weak var viewEFPSlips :       UIView?
    @IBOutlet weak var viewSummary :        UIView?
    
    @IBOutlet weak var viewDeal :    UIView?
    @IBOutlet weak var viewDiscussion :       UIView?
    @IBOutlet weak var viewProfile :        UIView?
    
    @IBOutlet weak var viewDiscussionTab :    UIView?
    @IBOutlet weak var viewForum :       UIView?
    
    @IBOutlet weak var tabBar  :    UITabBar?
    
    var strDealType: String = ""
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "DealsTableViewCell"
    let cellReuseIdentifierForum = "ForumTableViewCell"
    let cellReuseIdentifierPost = "RecentPostTableViewCell"

    
    
    
    
    //    let dictNotify: NSDictionary!
    var arrDict = [Data]()
    var arrForumDict = [DDForumData]()
    var arrRecentPostDict = [DDRecentPostData]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UpdateDesign()
        //  For multilining cell as per text WS response
        tableTransaction?.estimatedRowHeight = 133.5
        tableTransaction?.rowHeight = UITableViewAutomaticDimension
        tableDiscussion?.estimatedRowHeight = 133.5
        tableDiscussion?.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func UpdateDesign(){
        tabBar?.selectedItem = tabBar?.items![0]
        viewDeal?.isHidden = false
        viewDiscussion?.isHidden = true
        tableTransaction?.register(UINib(nibName: "DealsTableViewCell", bundle: nil), forCellReuseIdentifier: "DealsTableViewCell")
        tableDiscussion?.register(UINib(nibName: "ForumTableViewCell", bundle: nil), forCellReuseIdentifier: "ForumTableViewCell")
        tableDiscussion?.register(UINib(nibName: "RecentPostTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentPostTableViewCell")
        
        //navigation bar setting
        self.navigationController?.makeAIGContainerNavigationBar()
        self.view.backgroundColor = AIGColorUtility.navigationTintColor()
        self.tabBar?.selectedItem?.tag = 1
        self.title = "DEALS"
        tableTransaction?.tag = 1
        getHomeDealising()
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        //ask where it is first tab bar item
        if self.tabBar?.selectedItem?.tag == 1 {
            tableTransaction?.tag = 1
            print("111")
            self.title = "DEALS"
            viewDeal?.isHidden = false
            viewDiscussion?.isHidden = true
            getHomeDealising()
        }
        else if  self.tabBar?.selectedItem?.tag == 2 {
            tableDiscussion?.tag = 2
            print("222")
            self.title = "FORUM"
            strDealType = "FORUM"

            viewDiscussion?.isHidden = false
            viewDeal?.isHidden = true
            getForumList()
        }
        else{
            print("333")
            self.title = "PROFILE"
            viewDeal?.isHidden = true
            viewDiscussion?.isHidden = true
            // create the alert
            let alert = UIAlertController(title: "Desidime", message: "This section is under progress.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonTransactionPressed() {
        tableTransaction?.tag = 1
        viewTransaction?.backgroundColor = AIGColorUtility.viewSliderOrange()
        viewEFPSlips?.backgroundColor = AIGColorUtility.navigationBartintColor()
        viewSummary?.backgroundColor = AIGColorUtility.navigationBartintColor()
        strDealType = "top"
        getHomeDealising()
    }
    
    @IBAction func buttonEfpSlipsPrssed() {
        tableTransaction?.tag = 1
        viewEFPSlips?.backgroundColor = AIGColorUtility.viewSliderOrange()
        viewTransaction?.backgroundColor = AIGColorUtility.navigationBartintColor()
        viewSummary?.backgroundColor = AIGColorUtility.navigationBartintColor()
        strDealType = "popular"
        getPopularlising()
    }
    
    @IBAction func buttonSummarySlips() {
        tableTransaction?.tag = 1
        viewSummary?.backgroundColor = AIGColorUtility.viewSliderOrange()
        viewEFPSlips?.backgroundColor = AIGColorUtility.navigationBartintColor()
        viewTransaction?.backgroundColor = AIGColorUtility.navigationBartintColor()
        strDealType = "featured"
        getFeaturedDealising()
    }
    
    
    
    @IBAction func buttonDiscussionPressed() {
        strDealType = "FORUM"
        
        tableDiscussion?.tag = 2
        viewDiscussionTab?.backgroundColor = AIGColorUtility.viewSliderOrange()
        viewForum?.backgroundColor = AIGColorUtility.navigationBartintColor()
        getForumList()
    }
    
    @IBAction func buttonForumPrssed() {
        strDealType = "POSTS"
        
        tableDiscussion?.tag = 2
        viewForum?.backgroundColor = AIGColorUtility.viewSliderOrange()
        viewDiscussionTab?.backgroundColor = AIGColorUtility.navigationBartintColor ()
        getRecentPostList()
    }
    
    @IBAction func notificationClicked(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func settingClicked(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewSettingTableViewController") as! NewSettingTableViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //MARK:- Table view datasource & delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return arrDict.count
        }
        else{
            if strDealType == "FORUM"{
            return arrForumDict.count
            }
            else{
                return arrRecentPostDict.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1{
            
            let cell:DealsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? DealsTableViewCell)!
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let dealObj = arrDict[indexPath.row]
            let strOriginalPrize : String = String(describing: dealObj.originalPrice!)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: strOriginalPrize)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.lblActualPrize.attributedText = attributeString
            
            cell.lblTitle.text = dealObj.title
            cell.lblOfferPrize.text = "Rs " +  String(describing: dealObj.currentPrice!)
            if dealObj.offPercent == "0" {
                cell.lblPercentOff.isHidden = true
            }
            else{
                cell.lblPercentOff.text = dealObj.offPercent! + "% Off "
            }
            cell.btnLike.setTitle(String(describing: dealObj.voteCount!),for: .normal)
            cell.btnMsg.setTitle(String(describing: dealObj.allPostsCount!),for: .normal)
            
            let milliseconds :Float =  Float(dealObj.createdAt!)
            var seconds : Float = milliseconds / 1000.0
            var minutes : Float = seconds / 60.0
            var hours : Float = minutes / 60.0
            var day : Float = hours / 24.0
            
            cell.btnTime.setTitle(String(describing: day),for: .normal)
            let strImgUrl :String = String(describing: dealObj.image!)
            let fileUrl = NSURL(string: strImgUrl as String)
            cell.imgProduct.sd_setImage(with:fileUrl as URL!, placeholderImage: UIImage.init(named: "placeholder") )
            return cell
        }
        else{
            
            if strDealType == "FORUM" {
                let cell:ForumTableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierForum, for: indexPath) as? ForumTableViewCell)!
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let forumObject = arrForumDict[indexPath.row]
                
                cell.lblTitle.text = forumObject.title
                let strDescript = forumObject.descriptionValue
                
                if let htmlData = strDescript?.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)) {
                    do {
                        let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                        cell.lblDescription.attributedText = attributedText as NSAttributedString
                        
                    } catch let e as NSError {
                        print("Couldn't translate \(strDescript): \(e.localizedDescription) ")
                    }
                }
                //            cell.lblDescription.text = forumObject.descriptionValue
                
                cell.btnLike.setTitle(String(describing: forumObject.topicsCount!),for: .normal)
                cell.btnMsg.setTitle(String(describing: forumObject.postsCount!),for: .normal)
                
                let milliseconds :Float =  Float(forumObject.lastActivityAt!)
                var seconds : Float = milliseconds / 1000.0
                var minutes : Float = seconds / 60.0
                var hours : Float = minutes / 60.0
                var day : Float = hours / 24.0
                
                cell.btnTime.setTitle(String(describing: day),for: .normal)
                return cell
            }
            else{
                
                let cell:RecentPostTableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierPost, for: indexPath) as? RecentPostTableViewCell)!
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let forumObject = arrRecentPostDict[indexPath.row]
                
                cell.lblUsername.text = forumObject.user?.name
                let strDescript = forumObject.text
                
                if let htmlData = strDescript?.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)) {
                    do {
                        let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                        cell.lblDescription.attributedText = attributedText as NSAttributedString
                        
                    } catch let e as NSError {
                        print("Couldn't translate \(strDescript): \(e.localizedDescription) ")
                    }
                }
                //            cell.lblDescription.text = forumObject.descriptionValue
                let strOnlineDeal = (forumObject.topic?.forumName)! + " " + (forumObject.topic?.shareUrl)!
                
                cell.btnHotDeals.setTitle(strOnlineDeal,for: .normal)
                cell.btnLikePoints.setTitle(String(describing: forumObject.likeCount!),for: .normal)

                
                let milliseconds :Float =  Float(forumObject.createdAt!)
                var seconds : Float = milliseconds / 1000.0
                var minutes : Float = seconds / 60.0
                var hours : Float = minutes / 60.0
                var day : Float = hours / 24.0
                
                cell.btnTime.setTitle(String(describing: day),for: .normal)
                
                let strImgUrl :String = (forumObject.user?.image)!
                let fileUrl = NSURL(string: strImgUrl as String)
                cell.imgUser.sd_setImage(with:fileUrl as URL!, placeholderImage: UIImage.init(named: "placeholder") )

                return cell
            }
        }
    }

func getHomeDealising(){
    
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
    
    Alamofire.request("http://139.162.46.29/v3/deals.json?type=top", method: .get, parameters: nil,
                      encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0",
                                                                "Authorization": accessToken]).responseJSON {
                                                                    
                                                                    (response:DataResponse<Any>) in
                                                                    
                                                                    let responseCode  = response.response?.statusCode
                                                                    
                                                                    if responseCode == 200
                                                                    {
                                                                        if let JSON = response.result.value {
                                                                            print("JSON: \(JSON)")
                                                                            let objTopDeal = DDTopDealModel.init(object: JSON)
                                                                            print("JSON: \(objTopDeal)")
                                                                            
                                                                            if let arrDealObj = objTopDeal.deals?.data {
                                                                                self.arrDict  = arrDealObj
                                                                            }
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                self.tableTransaction? .reloadData()
                                                                            }
                                                                            
                                                                            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                                                        }
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


func getPopularlising(){
    
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
    
    Alamofire.request("http://139.162.46.29/v3/deals.json?type=popular", method: .get, parameters: nil,
                      encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0",
                                                                "Authorization": accessToken]).responseJSON {
                                                                    
                                                                    (response:DataResponse<Any>) in
                                                                    
                                                                    let responseCode  = response.response?.statusCode
                                                                    
                                                                    if responseCode == 200
                                                                    {
                                                                        if let JSON = response.result.value {
                                                                            print("JSON: \(JSON)")
                                                                            let objTopDeal = DDTopDealModel.init(object: JSON)
                                                                            print("JSON: \(objTopDeal)")
                                                                            
                                                                            if let arrDealObj = objTopDeal.deals?.data {
                                                                                self.arrDict  = arrDealObj
                                                                            }
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                self.tableTransaction? .reloadData()
                                                                            }
                                                                            
                                                                            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                                                        }
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

func getFeaturedDealising(){
    
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
    
    Alamofire.request("http://139.162.46.29/v3/deals.json?type=featured", method: .get, parameters: nil,
                      encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0",
                                                                "Authorization": accessToken]).responseJSON {
                                                                    
                                                                    (response:DataResponse<Any>) in
                                                                    
                                                                    let responseCode  = response.response?.statusCode
                                                                    
                                                                    if responseCode == 200
                                                                    {
                                                                        if let JSON = response.result.value {
                                                                            print("JSON: \(JSON)")
                                                                            let objTopDeal = DDTopDealModel.init(object: JSON)
                                                                            print("JSON: \(objTopDeal)")
                                                                            
                                                                            if let arrDealObj = objTopDeal.deals?.data {
                                                                                self.arrDict  = arrDealObj
                                                                            }
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                self.tableTransaction? .reloadData()
                                                                            }
                                                                            
                                                                            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                                                        }
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

func getForumList(){
    
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
    
    Alamofire.request("http://139.162.46.29/v3/forums", method: .get, parameters: nil,
                      encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0",
                                                                "Authorization": accessToken]).responseJSON {
                                                                    
                                                                    (response:DataResponse<Any>) in
                                                                    
                                                                    let responseCode  = response.response?.statusCode
                                                                    
                                                                    if responseCode == 200
                                                                    {
                                                                        if let JSON = response.result.value {
                                                                            print("JSON: \(JSON)")
                                                                            let objForumList = DDForumDDForumListingModel.init(object: JSON)
                                                                            print("JSON: \(objForumList)")
                                                                            
                                                                            if let arrForumObj = objForumList.data {
                                                                                self.arrForumDict  = arrForumObj
                                                                            }
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                self.tableDiscussion? .reloadData()
                                                                            }
                                                                            
                                                                            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                                                        }
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


func getRecentPostList(){
    
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
    
    Alamofire.request("https://stagingapi.desidime.com/v3/posts", method: .get, parameters: nil,
                      encoding: JSONEncoding.default, headers: ["X-Desidime-Client" : "0c50c23d1ac0ec18eedee20ea0cdce91ea68a20e9503b2ad77f44dab982034b0"]).responseJSON {
                        
                        (response:DataResponse<Any>) in
                        
                        let responseCode  = response.response?.statusCode
                        
                        if responseCode == 200
                        {
                            if let JSON = response.result.value {
                                print("JSON: \(JSON)")
                                let objPostList = DDRecentPostDDRecentPostModel.init(object: JSON)
                                print("JSON: \(objPostList)")
                                
                                if let arrPostObj = objPostList.data {
                                    self.arrRecentPostDict  = arrPostObj
                                }
                                
                                DispatchQueue.main.async {
                                    self.tableDiscussion? .reloadData()
                                }
                                
                                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                            }
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
