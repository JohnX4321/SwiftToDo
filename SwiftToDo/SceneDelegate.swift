//
//  SceneDelegate.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo: UISceneSession, options: UIScene.ConnectionOptions) {
        let content = TodoView().environmentObject(Todo())
        if let windowScene = scene as? UIWindowScene {
            let w = UIWindow(windowScene: windowScene)
            w.rootViewController = UIHostingController(rootView: content)
            self.window=w
            w.makeKeyAndVisible()
        }
    }
    
    
    
}
