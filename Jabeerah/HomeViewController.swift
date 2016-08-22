//
//  HomeViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/22/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddButton(sender: UIBarButtonItem) {
        
        
        //popover
        
        
        
         let VC = storyboard?.instantiateViewControllerWithIdentifier("PopOverViewController") as! PopOverViewController
         
         VC.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 500)
         
         let navController = UINavigationController(rootViewController: VC)
         
         navController.modalPresentationStyle = UIModalPresentationStyle.Popover
         
         let popOver = navController.popoverPresentationController
         popOver?.delegate = self
         popOver?.barButtonItem = sender as? UIBarButtonItem
         
         self.presentViewController(navController, animated: true, completion: nil)
    }
    
         func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
         return .None
    }//end of popover
 


}

 








    








