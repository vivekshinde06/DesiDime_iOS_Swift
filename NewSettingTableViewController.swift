//
//  NewSettingTableViewController.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 5/5/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit

class NewSettingTableViewController: UITableViewController {

    @IBOutlet weak var btnNotificationSound: UIButton?
    @IBOutlet weak var btnDealInstant: UIButton?
    @IBOutlet weak var btnOnceInaDay: UIButton?
    @IBOutlet weak var btnNever: UIButton?
    @IBOutlet weak var btnTopicNotifyOnApp: UIButton?
    @IBOutlet weak var btnTopicNotifyOnEmail: UIButton?
    @IBOutlet weak var btnProfileNotifyOnApp: UIButton?
    @IBOutlet weak var btnProfileNotifyOnEmail: UIButton?
    @IBOutlet weak var btnMilestoneNotifyOnApp: UIButton?
    @IBOutlet weak var btnMilestoneNotifyOnEmail: UIButton?
    @IBOutlet weak var btnLeatherNotifyOnApp: UIButton?
    @IBOutlet weak var btnLeatherNotifyOnEmail: UIButton?

    var strAlertStatus : String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "Setting"
//        let backButton = UIBarButtonItem(barButtonSystemItem:.rewind, target: self, action: #selector(backButtonTapped))
//        navigationItem.leftBarButtonItems = [backButton]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        
        let saveButton = UIBarButtonItem(barButtonSystemItem:.save, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [saveButton]
        
        // MARK: - UIButton Declaration

        btnNotificationSound?.isSelected = false
        btnDealInstant?.isSelected = false
        btnOnceInaDay?.isSelected = false
        btnNever?.isSelected = false
        btnTopicNotifyOnApp?.isSelected = false
        btnTopicNotifyOnEmail?.isSelected = false
        btnProfileNotifyOnApp?.isSelected = false
        btnProfileNotifyOnEmail?.isSelected = false
        btnMilestoneNotifyOnApp?.isSelected = false
        btnMilestoneNotifyOnEmail?.isSelected = false
        btnLeatherNotifyOnApp?.isSelected = false
        btnLeatherNotifyOnEmail?.isSelected = false

    }
    
    func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }

    @IBAction func notifiationSoundPressed(_ sender: Any) {
        btnNotificationSound?.isSelected = !(btnNotificationSound?.isSelected)! //toggle the text box
    }
    
    // MARK: - UIButton Functions

    @IBAction func instantPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        switch sender.tag {
        case 0:
            print("1")
            break
        case 1:
            print("2")
            break
        case 2:
            print("3")
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func onceInADayPressed(_ sender: Any) {
        btnOnceInaDay?.isSelected = !(btnOnceInaDay?.isSelected)! //toggle the text box
    }
    
    @IBAction func neverPressed(_ sender: Any) {
        btnNever?.isSelected = !(btnNever?.isSelected)! //toggle the text box
    }
    
    @IBAction func topicNotifyPressed(_ sender: Any) {
    btnTopicNotifyOnApp?.isSelected = !(btnTopicNotifyOnApp?.isSelected)! //toggle the text box
    }
    
    @IBAction func topicNotifyEmailPressed(_ sender: Any) {
        btnTopicNotifyOnEmail?.isSelected = !(btnTopicNotifyOnEmail?.isSelected)! //toggle the text box
    }
    
    @IBAction func profileNotifyPressed(_ sender: Any) {
        btnProfileNotifyOnApp?.isSelected = !(btnProfileNotifyOnApp?.isSelected)! //toggle the text box
    }
    @IBAction func profileNotifyEmailPressed(_ sender: Any) {
        btnProfileNotifyOnEmail?.isSelected = !(btnProfileNotifyOnEmail?.isSelected)! //toggle the text box
    }
   
    @IBAction func milestoneNotifyPressed(_ sender: Any) {
        btnMilestoneNotifyOnApp?.isSelected = !(btnMilestoneNotifyOnApp?.isSelected)! //toggle the text box
    }
    @IBAction func milestoneNotifyEmailPressed(_ sender: Any) {
        btnMilestoneNotifyOnEmail?.isSelected = !(btnMilestoneNotifyOnEmail?.isSelected)! //toggle the text box
    }
    @IBAction func leatherNotifyPressed(_ sender: Any) {
        btnLeatherNotifyOnApp?.isSelected = !(btnLeatherNotifyOnApp?.isSelected)! //toggle the text box
    }
    @IBAction func leatherNotifyEmailPressed(_ sender: Any) {
        btnLeatherNotifyOnEmail?.isSelected = !(btnLeatherNotifyOnEmail?.isSelected)! //toggle the text box
    }
    

    func saveButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
