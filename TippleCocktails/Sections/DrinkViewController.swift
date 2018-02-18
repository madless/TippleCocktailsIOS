//
//  DrinkViewController.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 18.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController, UITableViewDataSource {

    var drinkId: String?
    var drink: Drink?
    
    let INGREDIENT_CELL = "IngredientCell"
    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textViewInstruction: UITextView!
    @IBOutlet weak var drinkTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        fetchDrink()
    }
    
    func fetchDrink() {
        if let id = drinkId {
            ApiService.sharedInstance.getDrinkById(id: id, onSuccess: {
                drinkResponse in
                DispatchQueue.main.async {
                    self.drink = DrinkMapper.mapServerToUiModel(drink: drinkResponse)
                    if let imageUrl = self.drink?.drinkThumbUrl {
                        NetworkHelper.downloadImage(urlStr: imageUrl, imageView: self.drinkImageView)
                    }
                    if let title = self.drink?.name {
                        self.drinkTitleLabel.text = title
                    }
                    if let instruction = self.drink?.instructions {
                        self.textViewInstruction.text = instruction
                    }
                    self.tableView.reloadData()
                }
            }, onFailure: {
                error in
                if let e = error {
                    print(e)
                }
            })
        }
    }

    override func viewDidLayoutSubviews() {
        //tableView.frame.size = tableView.contentSize
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = drink?.ingredients?.count {
            print("ingredient count: ", count)
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: INGREDIENT_CELL)!
        let ingredient = drink?.ingredients?[indexPath.row]
        if let title = ingredient?.name {
            cell.textLabel?.text = title
        }
        if let measure = ingredient?.measure {
            cell.detailTextLabel?.text = measure
        }
        return cell
    }

}
