

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PopOverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    let ref = FIRDatabase.database().reference()
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var CategoryPickerView: UIPickerView!
    var Category = ["عكازات", "عربات متحركة", "أدوات دورات المياه", "أجهزة طبية", "أخرى"]

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var DeviceName: UITextField!
    @IBOutlet weak var Description: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        CategoryPickerView.delegate = self
        CategoryPickerView.dataSource = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
   
    var itemSelected = ""
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        itemSelected = Category[row]
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let theInfo:NSDictionary = info as NSDictionary
        let img:UIImage = theInfo.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        ImageView.image = img
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func AddPictureBtnAction(sender: UIButton) {
   
        
        
        // addPictureBtnAtion.enabled = false
        let alertController : UIAlertController = UIAlertController(title: "أضف جهازًا", message: "التقط صورة من الكاميرا أو اختر من الألبوم", preferredStyle: .ActionSheet)
        
        let cameraAction : UIAlertAction = UIAlertAction(title: "صورة من الكاميرا", style: .Default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
                
                self.imagePicker.sourceType = .Camera
                self.present()
                
            }else{
                self.presentViewController(self.showAlert("عذرًا", Message: "الكاميرا ليست متاحة في هذا الجهاز أو تم منع الوصول لها!"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "صورة من الألبوم", style: .Default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == true {
                
                self.imagePicker.sourceType = .PhotoLibrary
                self.present()
                
            }else{
                
                self.presentViewController(self.showAlert("عذرًا", Message: "ألبوم الصور ليس متاحًا في هذا الجهاز أو تم منع الوصول له!"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "إلغاء", style: .Cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func present(){
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    /*   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     print("info of the pic reached :\(info) ")
     self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
     
     } */
    
    //Show Alert
    func showAlert(Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .Alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { (alert) in
            print("User pressed ok function")
            
        }
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        return alertController
    }
    
    @IBAction func AddDeviceButton(sender: AnyObject) {
 
       
        if DeviceName.text == "" || Description.text == "" || ImageView.image == nil {
            let alert = UIAlertController(title: "عذرًا", message:"يجب عليك تعبئة معلومات الجهاز كاملة", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else {
            
            let imageName = NSUUID().UUIDString
            let storageRef = FIRStorage.storage().reference().child("Devices_Images").child("\(imageName).png")
    
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/png"
            
            if let uploadData = UIImagePNGRepresentation(self.ImageView.image!) {
                storageRef.putData(uploadData, metadata: metaData, completion: { (data, error) in
                    if error != nil {
                        print(error)
                        
                    } else {
                        print("Image Uploaded Succesfully")
                        let profileImageUrl = data?.downloadURL()?.absoluteString
                        
                        //
                        
                        let DeviceInfo = [
                            "ImageUrl":profileImageUrl!,
                            "DeviceName":self.DeviceName.text!,
                            "Description":self.Description.text!,
                            "Category":self.itemSelected
                        ]
                        
                        
                    self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEventOfType(.Value, withBlock: {(snapShot) in
                            if snapShot.exists(){
                                let numberOfDevicesAlreadyInTheDB = snapShot.childrenCount
                                if numberOfDevicesAlreadyInTheDB < 3{
                                    let newDevice = String("Device\(numberOfDevicesAlreadyInTheDB+1)")
                                    let userDeviceRef = self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid)
                                    userDeviceRef.observeSingleEventOfType(.Value, withBlock: {(userDevices) in
                                        if let userDeviceDict = userDevices.value as? NSMutableDictionary{
                                            
                                            userDeviceDict.setObject(DeviceInfo,forKey: newDevice)
                                            
                                            userDeviceRef.setValue(userDeviceDict)
                                        }
                                    })
                                }
                                else{
                                    let alert = UIAlertController(title: "عذرًا", message:"يمكنك إضافة ثلاثة أجهزة فقط كحد أقصى", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                }
                            }else{
         self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).setValue(["Device1" : DeviceInfo])

                        }
                        })
                        
                        //

                    } })
            }
            
              
        } //Big Big Else
} //Add Device Button
} // UIView Controlller