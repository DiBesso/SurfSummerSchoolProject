//
//  AppDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by Дмитрий Бессонов on 03.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Приложение запущено")
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Not running -> inactive
        print("Приложение начало запуск")
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Из Active в Inactive
        print("Приложение приостановило действие")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Inactive -> Active
        print("Снова активно")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // To background
        print("Приложение перешло в бэкграунд")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Background to foreground(Inactive)
        print("Снова становится активно")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Удалено из памяти")
    }
    

}

