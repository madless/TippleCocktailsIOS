//
//  SearchResponse.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 16.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let drinks: Array<DrinkResponse>?
}
