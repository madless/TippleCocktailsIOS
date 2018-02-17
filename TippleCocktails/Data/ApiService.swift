//
//  ApiService.swift
//  TippleCocktails
//
//  Created by Denys Mikhov on 15.02.2018.
//  Copyright © 2018 Denys Mikhov. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    let baseURL = "http://www.thecocktaildb.com/api/json/v1/1/"
    static let sharedInstance = ApiService()
    static let searchEndpoint = "search.php"
    static let filterEndpoint = "filter.php"
    
    static let ALCOHOL_TYPE_KEY = "a"
    static let SEARCH_KEY = "s"
    
    func prepareUrl(baseUrl: String, endpoint: String, params: String) -> String {
        var url = "\(baseUrl)\(endpoint)\(params)"
        url = url.replacingOccurrences(of: " ", with: "%20")
        return url
    }
    
    func prepareParams(params: Dictionary<String, String>) -> String {
        var paramsStr = ""
        if (!params.isEmpty) {
            for param in params {
                let prefix = paramsStr.isEmpty ? "?" : "&"
                paramsStr += "\(prefix)\(param.key)=\(param.value)"
            }
        }
        return paramsStr
    }
    
    func doRequest(url: String,
                   onSuccess: @escaping(Data) -> Void,
                   onFailure: @escaping(Error) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error -> Void in
            if(error != nil) {
                onFailure(error!)
            } else if (data != nil) {
                onSuccess(data!)
            } else {
                let e = NSError(domain:"Data is empty", code:404, userInfo:nil)
                onFailure(e)
            }
        })
        task.resume()
    }
    
    func getDrinksByAlcohol(alcoholType: String,
                            onSuccess: @escaping(SearchResponse) -> Void,
                            onFailure: @escaping(Error) -> Void) {
        let params = prepareParams(params: [ApiService.ALCOHOL_TYPE_KEY: alcoholType])
        let url = prepareUrl(baseUrl: baseURL, endpoint: ApiService.filterEndpoint, params: params)
        doRequest(url: url, onSuccess: {
            data in
            let decoder = JSONDecoder()
            do {
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                onSuccess(searchResponse)
            } catch let error {
                onFailure(error)
            }
        }, onFailure: {
            error in
            onFailure(error)
        })
    }
    
    func getCocktailByName(cocktailName: String,
                           onSuccess: @escaping(SearchResponse) -> Void,
                           onFailure: @escaping(Error) -> Void) {
        let params = prepareParams(params: [ApiService.SEARCH_KEY: cocktailName])
        let url = prepareUrl(baseUrl: baseURL, endpoint: ApiService.searchEndpoint, params: params)
        doRequest(url: url, onSuccess: {
            data in
            let decoder = JSONDecoder()
            do {
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                onSuccess(searchResponse)
            } catch let error {
                onFailure(error)
            }
        }, onFailure: {
            error in
            onFailure(error)
        })
    }
}
