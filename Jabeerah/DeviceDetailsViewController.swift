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
        mailVC.setSubject("طلب إعادة تدوير جهاز")
        mailVC.setMessageBody("هنا نكتب نص ايميل", isHTML: false)
        present(mailVC, animated: true, completion: nil)
    }
    
    // MARK: - Email Delegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
 /*
    @IBAction func WhatsAppSendButton(_ sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil
        {
        
            let whatsAppUrl = URL(string: "whatsapp:\(globalPhone)")
            
            
            
            if UIApplication.shared.canOpenURL(whatsAppUrl! as URL) {
                UIApplication.shared.openURL(whatsAppUrl! as URL)
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

 */

    //Share Button
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
   
    
   //Report Button
    @IBAction func ReportButton(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "عذرًا", message: "هل أنت متأكد من أنك تريد الإبلاغ عن هذا الإعلان؟", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: {(action: UIAlertAction)in
            let email = "jabeerah@support.com"
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([email])
            mailVC.setSubject("إعلان مزعج")
            mailVC.setMessageBody("Jabeerah Application. DeviceName: \(self.DeviceDetailsName.text!),DeviceDescription: \(self.DeviceDetailsDescription.text!), DeviceProvider: \(self.DeviceDetailsProvider.text!), City: \(self.DeviceDetailsCity.text!), ProviderPhone: \(self.globalPhone), ProviderEmail: \(self.globalEmail)", isHTML: false)
            self.present(mailVC, animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)

        /*
        var smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "matt@gmail.com"
        smtpSession.password = "xxxxxxxxxxxxxxxx"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.SASLPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        var builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Rool", mailbox: "itsrool@gmail.com")]
        builder.header.from = MCOAddress(displayName: "Matt R", mailbox: "matt@gmail.com")
        builder.header.subject = "My message"
        builder.htmlBody = "Yo Rool, this is a test message!"
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperationWithData(rfc822Data)
        sendOperation.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
            }
        } 
     */   
    } //Report Button
    
    
    } //DeviceDetailsViewController
