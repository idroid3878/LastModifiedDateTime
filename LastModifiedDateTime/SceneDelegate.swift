//
//  SceneDelegate.swift
//
//  Created by Son Nguyen on 04/06/2020

import UIKit
import SwiftUI

class HttpClass {

    var timestamp1: String?
    var tsn_url:String? = "https://capi.stage.9c9media.com/destinations/tsn_ios/platforms/iPad/contents/69585"
    
    init() {
        self.inithttp_timestamp_request()
    }
    
    func getTimeStamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let timestamp = timestamp1 {
            let date = dateFormatter.date(from: timestamp)
            return date!.description //timestamp
        }
        else {
            return "ERROR"
        }
        
        //(from: "2017-01-09T11:00:00.000Z")
        //(from: "2020-02-10T15:49:05Z")
        //print("timestamp1=\(timestamp1) ===> date: \(date) ===> \(date!.description)")
    }
 
    func inithttp_timestamp_request() -> Void {
        if let url = URL.init(string: tsn_url! ) {
            do {
                let data_retrieved = try Data.init(contentsOf:url)
                do {
                    let dataDecoded = try JSONSerialization.jsonObject(with: data_retrieved, options:.mutableLeaves)
                    if let json_dictionary = dataDecoded as? NSDictionary {
                        if let timestamp_found = json_dictionary["LastModifiedDateTime"] as? String {
                            if timestamp_found.isEmpty {
                                NSLog("ErrorTimeStampNotFound")
                                timestamp1 = "ErrorTimeStampNotFound!"
                            }
                            else {
                                timestamp1 = timestamp_found
                                NSLog("timestamp1=\(String(describing: timestamp1))")
                            }
                        }
                }
            }
            }
            catch{
            }
        }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        var httpinstance=HttpClass()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let thecontentview=ContentView( httpinstance.getTimeStamp() )
            window.rootViewController = UIHostingController(rootView: thecontentview )
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

