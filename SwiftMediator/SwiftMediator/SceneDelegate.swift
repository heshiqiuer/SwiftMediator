//
//  SceneDelegate.swift
//  SwiftMediator
//
//  Created by iOS on 27/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var manager: SceneDelegateManager = {
        return SceneDelegateManager.init(delegates: [SceneDe.init(window)])
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        manager.scene(scene, willConnectTo: session, options: connectionOptions)
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

        print("进入前台")
    }

    func sceneWillResignActive(_ scene: UIScene) {

        print("即将进入后台")
        manager.sceneWillResignActive(scene)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {

        print("即将进入前台")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {

        print("进入后台")
    }


}

