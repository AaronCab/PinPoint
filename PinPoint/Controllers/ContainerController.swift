//
//  ContainerViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import Toucan

class ContainerController: UIViewController {
    // MARK: - Properties
    
    var menuController: MenuController!
    var centerController: UIViewController!
    var eventsView: EventsViewController!
    var interestsView: InterestViewController!
    var isExpanded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    // MARK: - Handlers
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
    view.addSubview(centerController.view)
        centerController.didMove(toParent: self)
    }
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
    view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
            }
        animateStatusBar()
    }
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .Discover:
            print("show discover")
        case .Nearby:
            print("show nearby events")
        case .Favorites:
            print("show favorites")
        case .Messages:
            print("show messages")
        case .Preferences:
            print("show preferences")
        case .Profile:
            print("show profile")
        }
    }
    
    func animateStatusBar() { 
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}
extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?, menuCategories: MenuCategories?) {
        if !isExpanded {
            configureMenuController()
        }
                 isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
        
        guard let discover = centerController.children.first as? HomeController,
        let menuCategories = menuCategories else { return }
        switch menuCategories {
        case .discover:
            discover.discoverPageOn()
        case.nearby:
            discover.eventsPageOn()
        case .favorites:
            discover.favoritesPageOn()
        case .preferences:
            discover.preferencesPageOn()
        case .messaging:
            discover.messagingPageOn()
        case .profile:
            discover.profilePageOn()
        default:
            print("nothing is happening")
        }
    }
}



