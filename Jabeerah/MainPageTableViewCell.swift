//
//  MainPageTableViewCell.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/5/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {


    @IBOutlet weak var CategoryCellImageView: UIImageView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(_ Image:UIImage, Title:String , Description:String)
    {
       CategoryCellImageView.image = Image
       CategoryLabel.text = Title
       DescriptionLabel.text = Description
    }
    


}
