//
//  DrinkMapper.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 17.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import Foundation

class DrinkMapper {
    static func mapSeverToUiModels(drinks: Array<DrinkResponse>) -> Array<Drink> {
        var drinksUi = Array<Drink>()
        for d in drinks {
            var drinkThumbUrl = d.drinkThumbUrl
            if let url = drinkThumbUrl {
                let hasScheme = url.hasPrefix(Const.SCHEME_HTTP) || url.hasPrefix(Const.SCHEME_HTTPS)
                if (!hasScheme) {
                    drinkThumbUrl = "\(Const.SCHEME_HTTP)\(url)"
                }
            }
            let drinkUi = Drink(name: d.name, drinkThumbUrl: drinkThumbUrl)
            drinksUi.append(drinkUi)
        }
        return drinksUi
    }
}
