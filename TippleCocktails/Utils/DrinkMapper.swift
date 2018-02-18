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
            let drinkUi = mapServerToUiModel(drink: d)
            drinksUi.append(drinkUi)
        }
        return drinksUi
    }
    
    static func mapServerToUiModel(drink d: DrinkResponse) -> Drink {
        let drinkThumbUrl = prepareUrl(drink: d)
        let ingredients = prepareIngredients(drink: d)
        let drinkUi = Drink(id: d.id, name: d.name, category: d.category, iba: d.iba, alcoholic: d.alcoholic, glass: d.glass, instructions: d.instructions, drinkThumbUrl: drinkThumbUrl, ingredients: ingredients)
        return drinkUi
    }
    
    private static func prepareUrl(drink: DrinkResponse) -> String {
        var drinkThumbUrl = drink.drinkThumbUrl
        if let url = drinkThumbUrl {
            let hasScheme = url.hasPrefix(Const.SCHEME_HTTP) || url.hasPrefix(Const.SCHEME_HTTPS)
            if (!hasScheme) {
                drinkThumbUrl = "\(Const.SCHEME_HTTP)\(url)"
            }
        }
        if let url = drinkThumbUrl {
            return url
        } else {
            return ""
        }
    }
    
    private static func prepareIngredients(drink: DrinkResponse) -> Array<Ingredient> {
        var ingredients = Array<Ingredient>()
        if let name = drink.ingredient1, let measure = drink.measure1 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient2, let measure = drink.measure2 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient3, let measure = drink.measure3 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient4, let measure = drink.measure4 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient5, let measure = drink.measure5 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient6, let measure = drink.measure6 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient7, let measure = drink.measure7 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient8, let measure = drink.measure8 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient9, let measure = drink.measure9 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient10, let measure = drink.measure10 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient11, let measure = drink.measure11 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient12, let measure = drink.measure12 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient13, let measure = drink.measure13 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient14, let measure = drink.measure14 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        if let name = drink.ingredient15, let measure = drink.measure15 {
            ingredients.append(Ingredient(name: name, measure: measure))
        }
        return ingredients
    }
    
}
