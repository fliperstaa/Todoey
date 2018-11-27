//
//  AppDelegate.swift
//  Todoey
//
//  Created by Никита Гагаринов on 21/11/2018.
//  Copyright © 2018 nikita. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        
        do {
            _ = try Realm()
        } catch {
            print(error)
        }
        
        return true
    }
    
}
    

