//
//  Drink.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 17.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import Foundation

struct Drink {
    let id: String?
    let name: String?
    let category: String?
    let iba: String?
    let alcoholic: String?
    let glass: String?
    let instructions: String?
    let drinkThumbUrl: String?
    let ingredients: Array<Ingredient>?
}
