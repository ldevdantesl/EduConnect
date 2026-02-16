//
//  SceneDelegate.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 2.01.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appRouter: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let container = DIContainer()
        let appRouter = AppRouter(diContainer: container)
        appRouter.window = window
        
        self.appRouter = appRouter
        appRouter.start()
    }
}
