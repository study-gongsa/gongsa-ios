//
//  MainTabViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class MainTabViewController: UITabBarController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {

        authenticateUserAndConfigureUI()
    }

    // MARK: - Selectors

    // MARK: - Helpers
    func authenticateUserAndConfigureUI() {
        if isAuthenticated() {
            configureViewControllers()
            configureUI()
        } else {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }

    private func isAuthenticated() -> Bool { return true }

    private func configureUI() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        if #available(iOS 13.0, *) {
              let navBarAppearance = UINavigationBarAppearance()
             navBarAppearance.configureWithOpaqueBackground()
             navBarAppearance.backgroundColor = .white
             navigationController?.navigationBar.standardAppearance = navBarAppearance
             navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }

    private func configureViewControllers() {
        let searchGroupViewController = SearchGroupViewController()
        let nav1 = createNavigationViewController(image: UIImage(named: ""), rootViewController: searchGroupViewController)

        let groupListViewController = GroupListViewController()
        let nav2 = createNavigationViewController(image: UIImage(named: ""), rootViewController: groupListViewController)

        let createGroupViewController = CreateGroupViewController()
        let nav3 = createNavigationViewController(image: UIImage(named: ""), rootViewController: createGroupViewController)

        let profileViewController = ProfileViewController()
        let nav4 = createNavigationViewController(image: UIImage(named: ""), rootViewController: profileViewController)

        viewControllers = [nav1, nav2, nav3, nav4]
    }

    private func createNavigationViewController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }

}
