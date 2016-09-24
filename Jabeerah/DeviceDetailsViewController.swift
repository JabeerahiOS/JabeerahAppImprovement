//
//  DeviceDetailsViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/7/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import MessageUI

var  text = ""

class DeviceDetailsViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var DeviceDetailsImageView: UIImageView!
    @IBOutlet weak var DeviceDetailsProvider: UILabel!
    @IBOutlet weak var DeviceDetailsName: UILabel!
    @IBOutlet weak var DeviceDetailsDescription: UILabel!
    @IBOutlet weak var DeviceDetailsCity: UILabel!
    
   
    var strUserid : NSString!
   
   var globalEmail : String = "Test"
    var globalPhone : String = "Test"

  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(globalPhone)
        print(globalEmail)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        print("idis \(self.strUserid)")
        
         let ref = FIRDatabase.database().reference().child("UserDevices")
       
         self.navigationController?.navigationBar.tintColor = UIColor.white
        ref.child(byAppendingPath: self.strUserid as String).observe(.value, with: { snapshot in
            
            if let dict = snapshot.value as? NSMutableDictionary{
                
                print("dict is \(dict)")
  
                if let Provider = dict["name"] as? String
                {
                    self.DeviceDetailsProvider.text = Provider
                   
                }
                if let name = dict["DeviceName"] as? String
                {
                    self.DeviceDetailsName.text = name
                    self.navigationItem.title = name
                }
                if let ShortDescription = dict["Description"] as? String
                {
                    self.DeviceDetailsDescription.text = ShortDescription
                }
                if let City = dict["city"] as? String
                {
                    self.DeviceDetailsCity.text = City
                }
                if let Email = dict["email"] as? String
                {
                    self.globalEmail = Email
                }
                if let Phone = dict["phone"] as? String
                {
                    self.globalPhone = Phone
                }

                if let ImageUrl = dict["ImageUrl"] as? String
                {
                    print(ImageUrl)
                    self.DeviceDetailsImageView.downloadedFrom(link: ImageUrl)
                    
                }
              
              

            }
        })
        
        
     

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func CallButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil
        {
           //let url = NSURL(string: "tel://\(globalPhone)")
            var url:NSURL = NSURL(string: "tel://\(globalPhone)")!
           
            if UIApplication.shared.canOpenURL(url as! URL) {
           //     UIApplication.shared.canOpenURL(url as! URL)
                 UIApplication.shared.openURL(url as URL)
            }
            
            else {
                let errorAlert = UIAlertView(title: "عفواً", message: "لا يمكنك الاتصال بالرقم", delegate: self, cancelButtonTitle:"موافق")
                errorAlert.show()
            }
            
        }else {
            let alert = UIAlertController(title: "عذرًا", message:"لا بد أن تسجل في التطبيق كي تطلب الخدمة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        

    }
  
  
 

    @IBAction func MessageButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            let SMSurl: NSURL = NSURL  (string: "SMS:\(globalPhone)")!
            if UIApplication.shared.canOpenURL(SMSurl as URL)
            {
                UIApplication.shared.openURL(SMSurl as URL)
            }
            else
            {
                let errorAlert = UIAlertView(title: "عفواً", message: "لا يمكنك إرسال رسالة نصية", delegate: self, cancelButtonTitle:"موافق")
                errorAlert.show()
            }
        } else {
            
            let alert = UIAlertController(title: "عذرًا", message:"لا بد أن تسجل في التطبيق كي تطلب الخدمة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
        }

    }

   
    @IBAction func EmailSendButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil{
            
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([globalEmail])
            mailVC.setSubject("طلب اعادة تدوير جهاز")
            mailVC.setMessageBody("Email message string", isHTML: false)
            
            present(mailVC, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "عذرًا", message:"لا بد أن تسجل في التطبيق كي تطلب الخدمة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
        }

        
    }
  
    
    func sendEmail()
    {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        // هنا نسترجع ايميل البروفايدر من الفايربيس
        mailVC.setToRecipients(["\(globalEmail)"])
        mailVC.setSubject("طلب اعادة تدوير جهاز")
        mailVC.setMessageBody("هنا نكتب نص ايميل", isHTML: false)
        present(mailVC, animated: true, completion: nil)
    }
    
    // MARK: - Email Delegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func WhatsAppSendButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil
        {
            
            
        let whatsAppUrl = NSURL(string: "whatsapp://\(globalPhone)")
            
          //  let whatsAppUrl = NSURL(string: "whatsapp://send?text=\(globalPhone)")
            
            if UIApplication.shared.canOpenURL(whatsAppUrl as! URL) {
                UIApplication.shared.canOpenURL(whatsAppUrl as! URL)
            }
            else {
                let errorAlert = UIAlertView(title: "عفواً", message: "لا يمكنك الارسال عن طريق الواتس اب", delegate: self, cancelButtonTitle:"موافق")
                errorAlert.show()
            }
            
        } else {
            let alert = UIAlertController(title: "عذرًا", message:"لا بد أن تسجل في التطبيق كي تطلب الخدمة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
            
        }

    }

 
    func share(shareText:String?,shareImage:UIImage?){
        var objectsToShare = [AnyObject]()
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj as AnyObject)
        }
        if let shareImageObj = shareImage{
            objectsToShare.append(shareImageObj)
        }
        if shareText != nil || shareImage != nil{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }
    @IBAction func ShareButton(_ sender: AnyObject) {
     let img = DeviceDetailsImageView.image
     text = "Jabeerah Application. DeviceName: \(self.DeviceDetailsName.text!), DeviceProvider: \(self.DeviceDetailsProvider.text!)"
     share(shareText: text, shareImage: img)
  }
   
    } //DeviceDetailsViewController

 


