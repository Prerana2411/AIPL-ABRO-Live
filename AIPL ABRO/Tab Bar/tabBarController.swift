//
//  tabBarController.swift
//  AIPL ABRO
//
//  Created by promatics on 23/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController, UITabBarControllerDelegate{

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.delegate = self
        
        UserDefaults.standard.set(false, forKey: "pushToCart")
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//
//    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "pushToCart"){
            
            self.selectedIndex = 2
            
        }
        
        if UserDefaults.standard.bool(forKey: "category"){
            
            UserDefaults.standard.set(false, forKey: "category")
            
            self.selectedIndex = 1
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return viewController != tabBarController.selectedViewController
        
    }
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
////        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gotoSignIn"), object: nil)
////
////        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
////
////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
////
////            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
////        })
////
//
//
//    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    //    self.tabBarFunction()
        
        if selectedIndex == 4 && UserDefaults.standard.bool(forKey: "Login_Status"){

            //self.fetchData()

        }else{

           // self.tabBarFunction()

        }
        
        if selectedIndex == 2 {
            
            self.tabBarController?.selectedIndex = 2
            
        }else{
            
            // self.tabBarFunction()
            
        }
    }
   
    func tabBarFunction(){
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
//
//        self.navigationController?.pushViewController(vc, animated: true)
//
//        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
//
        let alert = UIAlertController(title: "AIPL ABRO", message: "Login To see first", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController

            self.navigationController?.pushViewController(vc, animated: true)

        }))
        
        self.present(alert, animated: true, completion: nil)

    }

}
