//
//  UIImageViewExtension.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageUrl(_ url : String) {
        let cache = NSString(string : url)
        
        if let cachedImage = ImageCacahe.shared.object(forKey: cache) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string : url) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = UIImage()
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data : data) {
                        ImageCacahe.shared.setObject(image, forKey: cache)
                        self.image = image
                    }
                }
            }.resume()
        }
    }
}
