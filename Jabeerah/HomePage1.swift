//
//  HomePage1.swift
//  
//
//  Created by Ruba O on 11/28/1437 AH.
//
//

import UIKit

class HomePage1: UIViewController , UITableViewDataSource {
    
    let Category = ["أخرى","أسرة طبية","أدوات دورات المياة","أجهزة قياس","عكازات","عربات متحركة"]
    
    @IBOutlet weak var categoryTable: UITableView!
   
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
          return Category.count
    }
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell : UITableViewCell = categoryTable.dequeueReusableCellWithIdentifier("Category1", forIndexPath: indexPath)as!UITableViewCell
    
        myCell.textLabel?.text = Category[indexPath.row]
        mycell.imageView?.image = UIImage(named:Category[indexPath.row] )
        return myCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
