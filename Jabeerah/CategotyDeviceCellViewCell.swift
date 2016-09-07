//
//  CategotyDeviceCellViewCell.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/6/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class CategotyDeviceCellViewCell: UITableViewCell {
    
    @IBOutlet weak var CategoryDeviceImage: UIImageView!
    @IBOutlet weak var DeviceName: UILabel!
    @IBOutlet weak var DeviceDescription: UILabel!
    
    //Will Add it. 
  //  @IBOutlet weak var City: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //Will Add the city.
    func configureCell(DviceName:String , Description:String)
    {
        //CategoryDeviceImage.image = Image
        DeviceName.text = DviceName
        DeviceDescription.text = Description
        
    }


}
