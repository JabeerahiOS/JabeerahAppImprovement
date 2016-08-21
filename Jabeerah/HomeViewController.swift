//
//  HomeViewController.swift
//  Jabeerah
//
//  Created by alaa on 11/18/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//


import UIKit


class HomeViewController: UIViewController,UIPopoverPresentationControllerDelegate{
    
    //popover
    @IBAction func BarButtonTapped(sender: AnyObject) {
   
        
        let VC = storyboard?.instantiateViewControllerWithIdentifier("PopOverController") as! PopOverViewController
        
        VC.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 300)
        
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
    
    ///////////////////////////////////
    
    
}


