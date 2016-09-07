//
//  DeviceDetailsViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/7/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class DeviceDetailsViewController: UIViewController {

    @IBOutlet weak var DeviceDetailsImageView: UIImageView!
    @IBOutlet weak var DeviceDetailsProvider: UILabel!
    @IBOutlet weak var DeviceDetailsName: UILabel!
    @IBOutlet weak var DeviceDetailsDescription: UILabel!
    @IBOutlet weak var DeviceDetailsCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PhoneCallButton(sender: AnyObject) {
    }
    
    @IBAction func WhatsAppButton(sender: AnyObject) {
    }
    
    @IBAction func EmailButton(sender: AnyObject) {
    }
    
    @IBAction func MsgButton(sender: AnyObject) {
    }

 

}
