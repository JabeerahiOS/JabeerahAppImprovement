//  HomePage1.swift
//
//
//  Created by Ruba O on 11/28/1437 AH.
//
//


import UIKit
class HomePage1: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    
  @IBOutlet weak var categoryTable: UITableView!

    
    
 var CategoryImage = [UIImage(named: "icon-181919"),UIImage(named: "icon-139466"),UIImage(named: "icon-181919"),UIImage(named: "icon-10717"),UIImage(named: "icon-198070"),UIImage(named: "icon-45650"),UIImage(named: "icon-26589")]
  var CategoryTitle: NSMutableArray = ["أخرى","أسرة طبية","أدوات دورات المياة","أجهزة قياس","عكازات","عربات متحركة"]
    
    
 override func viewDidLoad()
 {
    super.viewDidLoad()
        categoryTable.delegate = self
        categoryTable.dataSource = self

   }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Categorycell") as? Categorycell
    
        {
            var img: UIImage!
            img = CategoryImage[indexPath.row]
            
            cell.configureCell(img, Title: CategoryTitle[indexPath.row] as! String)
            return cell
        }else
        {
            return Categorycell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryTitle.count
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let upcoming: SepecificcategoryTable = segue.destinationViewController as! SepecificcategoryTable
        let myindexpath = self.CategoriesTV.indexPathForSelectedRow
        let titleString = self.CategoryTitle.objectAtIndex((myindexpath?.row)!) as? String
        
        upcoming.titlestring = titleString
        
        self.CategoriesTV.deselectRowAtIndexPath(myindexpath!, animated: true)
    }

}

//  HomePage1.swift
//  
//
//  Created by Ruba O on 11/28/1437 AH.
//
//

import UIKit

class HomePage1: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var categoryTable: UITableView!

    var Category = ["أخرى","أسرة طبية","أدوات دورات المياة","أجهزة قياس","عكازات","عربات متحركة"]
    var images = [UIImage(named: "icon-181919"),UIImage(named: "icon-139466"),UIImage(named: "icon-181919"),UIImage(named: "icon-10717"),UIImage(named: "icon-198070"),UIImage(named: "icon-45650"),UIImage(named: "icon-26589")]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
          return Category.count
    }
    
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Categorycell", forIndexPath: indexPath)as!customCell
       cell.photo.images = images[indexPath.row]
        cell.name.text = Category[indexPath.row]
        return cell
    }
  }
