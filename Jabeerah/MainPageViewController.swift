//
//  MainPageViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/5/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var MainPageTableView: UITableView!

    var CategoryImage = [UIImage(named: "عربات متحركة"), UIImage(named: "عكازات"), UIImage(named: "أجهزة قياس"), UIImage(named: "أسرة طبية") , UIImage(named: "معدات دورات المياه") , UIImage(named: "أخرى")]
    var CategoryTitle: NSMutableArray = ["عربات متحركة","عكازات","أجهزة قياس","أسرة طبية","معدات دورات المياه","أخرى"]
    var CategoryDescription = ["...", "..." , "..." , "..." , "..." , "..."]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainPageTableView.delegate = self
        MainPageTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? MainPageTableViewCell
        {
            var img: UIImage!
            img = CategoryImage[indexPath.row]
            
            cell.configureCell(img, Title: CategoryTitle[indexPath.row] as! String, Description: CategoryDescription[indexPath.row])
          
            
            return cell
        }else
        {
            return MainPageTableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryTitle.count
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowCategoryDevice", sender: self)
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let upcoming: CategoryDeviceViewController = segue.destinationViewController as! CategoryDeviceViewController
        let myindexpath = self.MainPageTableView.indexPathForSelectedRow
        let titleString = self.CategoryTitle.objectAtIndex((myindexpath?.row)!) as? String
        upcoming.titlestring = titleString
        self.MainPageTableView.deselectRowAtIndexPath(myindexpath!, animated: true)
    }
    
*/

    
    
    @IBAction func AddButton(sender: AnyObject) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


