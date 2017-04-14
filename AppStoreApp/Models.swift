//
//  Models.swift
//  AppStoreApp
//
//  Created by Eric Chang on 4/13/17.
//  Copyright © 2017 Eric Chang. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    static func fetchFeaturedApps() {
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                guard let json = jsonData as? [String: AnyObject],
                    let categories = json["categories"] as? [[String: AnyObject]]
                    else { return }
                
                var appCategories = [AppCategory]()
                
                for dict in categories {
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeys(dict)
                    appCategories.append(appCategory)
                }
                
                print(appCategories)
            }
            catch {
                print(error)
            }
            
            }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        let annieApp = App()
        annieApp.name = "Annie Tung"
        annieApp.imageName = "annie_tung"
        annieApp.category = "Kagami Member"
        annieApp.price = NSNumber(value: 999.99)
        
        apps.append(annieApp)
        bestNewAppsCategory.apps = apps
        
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGamesApps = [App]()
        
        let eashirApp = App()
        eashirApp.name = "Eashir Arafat"
        eashirApp.imageName = "eashir_arafat"
        eashirApp.category = "Kagami Member"
        eashirApp.price = NSNumber(value: 0.99)
        
        bestNewGamesApps.append(eashirApp)
        bestNewGamesCategory.apps = bestNewGamesApps
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
    
}


class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
}
