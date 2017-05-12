//
//  SettingViewController.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 5/3/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Setting"
        let backButton = UIBarButtonItem(barButtonSystemItem:.rewind, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [backButton]

    }

    func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
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
