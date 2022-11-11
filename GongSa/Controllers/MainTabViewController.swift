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

        configureViewControllers()
        configureUI()
//        authenticateUserAndConfigureUI()
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
//                self.navigationController?.pushViewController(RegistrationViewController(), animated: true) // DEBUG
            }
        }
    }

    private func isAuthenticated() -> Bool { return false }

    private func configureUI() {

        tabBar.tintColor = UIColor.gsGreen
        tabBar.unselectedItemTintColor = UIColor.gsLightGray

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
        let searchGroupNav = createNavigationViewController(image: UIImage(named: "home"), rootViewController: searchGroupViewController)

        let groupListViewController = GroupListViewController()
        let groupListNav = createNavigationViewController(image: UIImage(named: "hamburger"), rootViewController: groupListViewController)

        let createGroupViewController = CreateGroupViewController()
        let createGroupNav = createNavigationViewController(image: UIImage(named: "create"), rootViewController: createGroupViewController)

        let profileViewController = ProfileViewController()
        let profileViewNav = createNavigationViewController(image: UIImage(named: "profile"), rootViewController: profileViewController)

        viewControllers = [searchGroupNav, groupListNav, createGroupNav, profileViewNav]
    }

    private func createNavigationViewController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }

}
