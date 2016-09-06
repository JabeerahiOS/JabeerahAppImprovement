//
//  CategoryExtraVersion.swift
//  Jabeerah
//
//  Created by Ruba O on 12/5/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//


import UIKit

class CategoryExtraVersion: UIViewController , UITableViewDelegate , UITableViewDataSource
{
    @IBOutlet weak var CategoryTable: UITableView!
    
    
    var CategoryImage = [UIImage(named: "عربات متحركة"),UIImage(named: "عكازات"),UIImage(named: "أجهزة قياس"),UIImage(named: "معدات دورات المياه"),UIImage(named: "أسرة طبية"),UIImage(named: "أخرى")]
    
    var CategoryTitle :NSMutableArray =
        ["أخرى","أسرة طبية","أدوات دورات المياة","أجهزة قياس","عكازات","عربات متحركة"]
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! CategoryCell
        
        
        cell.CategoryPhoto.image = CategoryImage[indexPath.row]
        cell.CategoryType.text = CategoryTitle[indexPath.row]
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return CategoryTitle.count
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        CategoryTable.delegate = self
        CategoryTable.dataSource = self
    }
    // copy -paste only from Marya Project
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("ShowCategoryDevice", sender: self)
    }
    
    // copy -paste only from Marya Project
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let upcoming: DeviceDetail = segue.destinationViewController as! DeviceDetail
        let myindexpath = self.Category.indexPathForSelectedRow
        let titleString = self.CategoryTitle.objectAtIndex((myindexpath?.row)!) as? String
        
        upcoming.titlestring = titleString
        
        self.Category.deselectRowAtIndexPath(myindexpath!, animated: true)
    }
    
}

