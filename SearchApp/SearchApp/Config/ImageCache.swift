//
//  ImageCache.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import Foundation
import UIKit

class ImageCacahe {
    static let shared = NSCache<NSString, UIImage>()
    private init(){}
}
