//
//  MainPageViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/5/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainPageViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var MainPageTableView: UITableView!

    var CategoryImage = [UIImage(named: "عربات متحركة"), UIImage(named: "عكازات"), UIImage(named: "أجهزة قياس"), UIImage(named: "أسرة طبية") , UIImage(named: "معدات دورات المياه") , UIImage(named: "أخرى")]
    var CategoryTitle: NSMutableArray = ["عربات متحركة","عكازات","أجهزة قياس","أسرة طبية","معدات دورات المياه","أخرى"]
    var CategoryDescription = ["...", "..." , "..." , "..." , "..." , "..."]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        MainPageTableView.delegate = self
        MainPageTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MainPageTableViewCell
        {
            cell.accessoryType = .disclosureIndicator
            var img: UIImage!
            img = CategoryImage[(indexPath as NSIndexPath).row]
        
        cell.configureCell(img, Title: CategoryTitle[(indexPath as NSIndexPath).row] as! String, Description: CategoryDescription[(indexPath as NSIndexPath).row])
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }else
        {
            return MainPageTableViewCell()
 
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryTitle.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowCategoryDevice", sender: self)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCategoryDevice" {
            let upcoming: CategoryDeviceViewController = segue.destination as! CategoryDeviceViewController
            let myindexpath = self.MainPageTableView.indexPathForSelectedRow
            let titleString = self.CategoryTitle.object(at: ((myindexpath as NSIndexPath?)?.row)!) as? String
            upcoming.titlestring = titleString
            self.MainPageTableView.deselectRow(at: myindexpath!, animated: true)
            
        }else  {
            let upcoming: PopOverViewController = segue.destination as! PopOverViewController
            
        }
    }
    


    @IBAction func AddButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "AddDevice", sender: nil)
        } else {
            let alert = UIAlertController(title: "عذرًا", message:"يجب أن تسجل كي تضيف جهازًا", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}

        }
        
        }


    
       
    } //MainPageViewController


/*
 

 
 */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/


