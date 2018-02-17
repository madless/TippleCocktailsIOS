//
//  NetworkHelper.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 18.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import Foundation
import UIKit

class NetworkHelper {
    static func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    static func downloadImage(urlStr: String, imageView: UIImageView) {
        let url = URL(string: urlStr)!
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
