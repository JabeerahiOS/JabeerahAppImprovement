//
//  ExtensionUIImageView.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/18/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

extension image {
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
}