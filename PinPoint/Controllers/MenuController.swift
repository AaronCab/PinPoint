//
//  MenuController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuOptionCell"

class MenuController: UIViewController {
    
    // MARK: - Properties
    var tableView: UITableView!
    var delegate: HomeControllerDelegate?
    var menuDelegate: MenuControllerDelegate?
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Handlers
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.1910400689, green: 0.2061233521, blue: 0.2311887741, alpha: 1)
        tableView.separatorStyle = .none
        tableView.rowHeight = 64
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
    }
}
extension MenuController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! MenuOptionsCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        cell.selectionStyle = .default
        cell.backgroundColor = .clear
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "   P I N P O I N T"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 36)
        header.textLabel?.backgroundColor = UIColor.clear
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = #colorLiteral(red: 0.1910400689, green: 0.2061233521, blue: 0.2311887741, alpha: 1)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        if indexPath.row == 0 {
            delegate?.handleMenuToggle(forMenuOption: menuOption, menuCategories: .discover)
        }
        if indexPath.row == 1 {
            delegate?.handleMenuToggle(forMenuOption: menuOption, menuCategories: .nearby)
        }
        if indexPath.row == 2 {
            delegate?.handleMenuToggle(forMenuOption: menuOption, menuCategories: .favorites)
        }
        if indexPath.row == 3 {
            delegate?.handleMenuToggle(forMenuOption: menuOption, menuCategories: .profile)
        }
      
        }
    }
