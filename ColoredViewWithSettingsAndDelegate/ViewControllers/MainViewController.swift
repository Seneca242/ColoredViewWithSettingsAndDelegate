//
//  MainViewController.swift
//  ColoredViewWithSettingsAndDelegate
//
//  Created by Дмитрий Дмитрий on 16.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColoForView(with color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(
            red: 225/225,
            green: 200/225,
            blue: 100/225,
            alpha: 1
        )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainVCColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColoForView(with color: UIColor) {
        view.backgroundColor = color
    }
    
    
}
