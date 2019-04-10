//
//  Protocols.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

protocol HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?, menuCategories: MenuCategories?)
}
protocol MenuControllerDelegate {
    func buttonPressed()
}
