//
//  ViewController.swift
//  ColoredViewWithSettingsAndDelegate
//
//  Created by Дмитрий Дмитрий on 15.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 15
        redLabel.textColor = .white
        greenLabel.textColor = .white
        blueLabel.textColor = .white
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    
        setColorForView()
        setValueForLabel(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        setColorForView()
        
        switch sender {
        case redSlider:
            setValueForLabel(for: redLabel)
        case greenSlider:
            setValueForLabel(for: greenLabel)
        default:
            setValueForLabel(for: blueLabel)
        }
    }
    private func setColorForView() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValueForLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = convertSliderValueToString(with: redSlider)
            case greenLabel:
                label.text = convertSliderValueToString(with: greenSlider)
            default:
                label.text = convertSliderValueToString(with: blueSlider)
            }
        }
    }
        
//    private func setValueForLabel(for label: UILabel) {
//        switch label {
//        case redLabel:
//            label.text = convertSliderValueToString(with: redSlider)
//        case greenLabel:
//            label.text = convertSliderValueToString(with: greenSlider)
//        default:
//            label.text = convertSliderValueToString(with: blueSlider)
//        }
//    }
        
    
    private func convertSliderValueToString(with slider: UISlider) -> String {
        String(format: "%.2f",slider.value)
    }
    
}
