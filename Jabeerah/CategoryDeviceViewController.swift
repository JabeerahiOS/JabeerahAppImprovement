//
//  CategoryDeviceViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/6/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class CategoryDeviceViewController: UIViewController{

     var DeviceNamesArray: NSMutableArray = []
    var titlestring: String!
    
    @IBOutlet weak var CategoryDeviceTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    //    CategoryDeviceTV.dataSource = self
    //  CategoryDeviceTV.delegate = self
            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
