//
//  AppDelegate.swift
//  MovieViewer
//
//  Created by Erica Lee on 1/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //did Finish Launching -> Very first function to run when the app opens 
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //story board name is called Main
        
        //get navigation controller to get all the view controllers - had to give storyboard ID
        let nowPlayingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MovieNavigationController") as! UINavigationController
        nowPlayingNavigationController.navigationBar.barStyle = UIBarStyle.Black
        nowPlayingNavigationController.navigationBar.tintColor = UIColor.yellowColor()
        nowPlayingNavigationController.title = "Now Playing"

        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! collectionViewController
        nowPlayingViewController.endpoint = "now_playing"
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        //nowPlayingNavigationController.tabBarItem.image = UIImage(named: "TopMovie")
        
        
        //get navigation controller to get all the view controllers - had to give storyboard ID
        let topRatedNavigationController = storyboard.instantiateViewControllerWithIdentifier("MovieNavigationController") as! UINavigationController
        
        let topRatedViewController = topRatedNavigationController.topViewController as! collectionViewController
        topRatedViewController.endpoint = "top_rated"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        
        let tabBarController = UITabBarController()
        //pass in an array of view controllers that you want to use
        tabBarController.viewControllers = [nowPlayingNavigationController, topRatedNavigationController]
        
        tabBarController.tabBar.barTintColor = UIColor.blackColor()
        tabBarController.tabBar.tintColor = UIColor.yellowColor()

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

