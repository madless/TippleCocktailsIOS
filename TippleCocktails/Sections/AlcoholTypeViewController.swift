//
//  AlcoholTypeViewController.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 17.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import UIKit

class AlcoholTypeViewController: UIViewController, UITableViewDataSource {

    let DRINK_CELL = "DrinkCell"
    
    var drinks = Array<Drink>()
    var alcoholType: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alcoholType = parent?.restorationIdentifier
        self.navigationItem.title = parent?.restorationIdentifier
        print("alcoholType: ", alcoholType)
        
        fetchDrinksFromServer()
    }

    func fetchDrinksFromServer() {
        print("fetchDrinksFromServer alcoholType: ", alcoholType)
        if let alcoholType = self.alcoholType {
            print("Start fetching ", alcoholType, "...")
            ApiService.sharedInstance.getDrinksByAlcohol(alcoholType: alcoholType, onSuccess: {
                searchResponse in
                self.drinks = DrinkMapper.mapSeverToUiModels(drinks: searchResponse.drinks!)
                DispatchQueue.main.async {
                    print("Fetched ", alcoholType)
                    self.tableView.reloadData()
                }
            }, onFailure: {
                error in
                print(error)
            })
        } else {
            print("Alcohol type is nil")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.DRINK_CELL, for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.row]
        cell.drinkTitleLabel?.text = drink.name
        if let urlStr = drink.drinkThumbUrl {
            NetworkHelper.downloadImage(urlStr: urlStr, imageView: cell.drinkImageView)
        }
        return cell
    }
}
