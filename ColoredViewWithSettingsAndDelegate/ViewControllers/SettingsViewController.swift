//
//  ViewController.swift
//  ColoredViewWithSettingsAndDelegate
//
//  Created by Дмитрий Дмитрий on 15.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var mainVCColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        mainView.backgroundColor = mainVCColor
        
        setValueForSliders()
        setValueForTF(redTextField, greenTextField, blueTextField)
        setValueforLabels(redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        setColorForView()
        
        switch sender {
        case redSlider:
            setValueforLabels(redLabel)
            setValueForTF(redTextField)
        case greenSlider:
            setValueforLabels(greenLabel)
            setValueForTF(greenTextField)
        default:
            setValueforLabels(blueLabel)
            setValueForTF(blueTextField)
        }
    }
    @IBAction func doneButtonPressed() {
        delegate.setColoForView(with: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func setColorForView() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setValueForTF(_ textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = setStringToValue(for: redSlider)
            case greenTextField:
                textField.text = setStringToValue(for: greenSlider)
            default:
                textField.text = setStringToValue(for: blueSlider)
            }
        }
    }
    
    private func setValueforLabels(_ labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = setStringToValue(for: redSlider)
            case greenLabel:
                label.text = setStringToValue(for: greenSlider)
            default:
                label.text = setStringToValue(for: blueSlider)
            }
        }
    }

    
//    private func setValueForLabels(_ label: UILabel) {
//        switch label {
//        case redLabel:
//            label.text = setStringToValue(for: redSlider)
//        case greenLabel:
//            label.text = setStringToValue(for: greenSlider)
//        default:
//            label.text = setStringToValue(for: blueSlider)
//        }
//    }
//
//    private func setValueForTF(_ textField: UITextField) {
//        switch textField {
//        case redTextField:
//            textField.text = setStringToValue(for: redSlider)
//        case greenTextField:
//            textField.text = setStringToValue(for: greenSlider)
//        default:
//            textField.text = setStringToValue(for: blueSlider)
//        }
//    }
    
    private func setStringToValue(for slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValueForSliders() {
        let ciColor = CIColor(color: mainVCColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default
        )
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if let currentText = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentText, animated: true)
                setValueforLabels(redLabel)
            case greenTextField:
                greenSlider.setValue(currentText, animated: true)
                setValueforLabels(greenLabel)
            default:
                blueSlider.setValue(currentText, animated: true)
                setValueforLabels(blueLabel)
            }
            setColorForView()
            return
        }
        showAlert(title: "Wrong format", message: "Enter correct value")
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        textField.inputAccessoryView = keyboardToolBar
        keyboardToolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )

        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        keyboardToolBar.items = [flexBarButton, doneButton]
    }


}
