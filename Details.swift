//
//  Details.swift
//  Jabeerah
//
//  Created by Ruba O on 12/5/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//

import UIKit

class Details: UIViewController
{
    var strUserid : NSString!
    
    @IBOutlet weak var DeviceImage: UIImageView!
    @IBOutlet weak var DeviceProvider: UILabel!
    @IBOutlet weak var DeviceLocation: UILabel!
    @IBOutlet weak var DeviceName: UILabel!
    @IBOutlet weak var Descript: UITextView!
    /* @IBAction func text2share(sender: AnyObject) {
     
     let text2share = "Check out this 😍✨ \r\n Business Name:  \(self.BusinessNameL.text!)  \r\n Phone: \(self.PhoneNumberTV.text!) \r\n Category: \(self.CategoryL.text!) \r\n Website: \(self.Website1TV.text!) \r\n in Business Wallet app 📲"
     let objects2Share = [text2share]
     
     
     let activityVC = UIActivityViewController(activityItems: objects2Share, applicationActivities: nil)
     
     let excludeActivities = [UIActivityTypePostToFacebook]
     
     activityVC.excludedActivityTypes = excludeActivities
     self.presentViewController(activityVC, animated: true, completion: nil)
     
     }*/
    
    /* func getImageOfScrollView()->UIImage{
     var snapshot = UIImage();
     
     UIGraphicsBeginImageContextWithOptions(self.scrollview.contentSize, false, UIScreen.mainScreen().scale)
     
     // save initial values
     let savedContentOffset = self.scrollview.contentOffset;
     let savedFrame = self.scrollview.frame;
     let savedBackgroundColor = self.scrollview.backgroundColor
     
     // reset offset to top left point
     self.scrollview.contentOffset = CGPointZero;
     // set frame to content size
     self.scrollview.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, self.scrollview.contentSize.width, self.scrollview.contentSize.height);
     // remove background
     self.scrollview.backgroundColor = UIColor.clearColor()
     
     self.scrollview.layer.renderInContext(UIGraphicsGetCurrentContext()!)
     // and get image
     snapshot = UIGraphicsGetImageFromCurrentImageContext();
     
     
     //let snapshot = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
     print("Save Business Card ")
     let alertController = UIAlertController(title: "Save Business Card", message: "Business Card has been saved to your photo library successfully ", preferredStyle: .Alert)
     alertController.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
     self.presentViewController(alertController, animated: true, completion: nil)
     
     
     // and return everything back
     //  tempView.subviews[0].removeFromSuperview()
     // tempSuperView?.addSubview(self.scrollview)
     
     // restore saved settings
     self.scrollview.contentOffset = savedContentOffset;
     self.scrollview.frame = savedFrame;
     self.scrollview.backgroundColor = savedBackgroundColor
     
     UIGraphicsEndImageContext();
     
     return snapshot
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("idis \(self.strUserid)")
        
        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users")
        
        ref.childByAppendingPath(self.strUserid as String).observeEventType(.Value, withBlock: { snapshot in
            
            if let dict = snapshot.value as? NSMutableDictionary{
                
                print("dict is \(dict)")
                
                
                
                if let Email = dict["Email"] as? String
                {
                    self.EmailTV.text = Email
                }
                if let name = dict["BusinessName"] as? String
                {
                    self.BusinessNameL.text = name
                    self.navigationItem.title = name
                }
                if let ShortDescription = dict["ShortDescription"] as? String
                {
                    self.ShortDescriptionL.text = ShortDescription
                }
                if let City = dict["City"] as? String
                {
                    self.CityL.text = City
                }
                if let ContactMe = dict["ContactMe"] as? String
                {
                    self.ContactMeTV.text = ContactMe
                }
                if let PhoneNumber = dict["PhoneNumber"] as? String
                {
                    self.PhoneNumberTV.text = PhoneNumber
                }
                if let Website1 = dict["Website1"] as? String
                {
                    self.Website1TV.text = Website1
                }
                if let Website2 = dict["Website2"] as? String
                {
                    self.Website2TV.text = Website2
                }
                if let Category = dict["Category"] as? String
                {
                    self.CategoryL.text = Category
                }
                if let Details = dict["Details"] as? String
                {
                    self.DetailsTV.text = Details
                }
            }
        })
        
        
    }
    
    @IBAction func Email(sender: AnyObject)
    {
    }
    
    @IBAction func Call(sender: AnyObject)
    {
    }
    @IBAction func Sms(sender: AnyObject)
    {
    }
    @IBAction func WhatsApp(sender: AnyObject)
    {
    }
    
}