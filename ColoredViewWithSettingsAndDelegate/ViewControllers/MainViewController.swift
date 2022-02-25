//
//  MainViewController.swift
//  ColoredViewWithSettingsAndDelegate
//
//  Created by Дмитрий Дмитрий on 16.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 128/255,
            green: 222/255,
            blue: 145/255,
            alpha: 1
        )
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainViewColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(color: UIColor) {
        view.backgroundColor = color
    }
}

