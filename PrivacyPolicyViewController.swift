//
//  PrivacyPolicyViewController.swift
//  AIPL ABRO
//
//  Created by promatics on 2/5/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var bell_NavigationItem: UIBarButtonItem!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.title = "Privacy Policy"
    }

    //MARK: functions
    
    @IBAction func bell_NavigtionItem(_ sender: Any) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
}
