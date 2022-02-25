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
    
    var mainViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        mainView.backgroundColor = mainViewColor
        viewColorBreakDown()
        
        setValueForLabel(label: redLabel)
        setValueForTF(textField: redTextField)
        
        setValueForLabel(label: greenLabel)
        setValueForTF(textField: greenTextField)
        
        setValueForLabel(label: blueLabel)
        setValueForTF(textField: blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValueForLabel(label: redLabel)
            setValueForTF(textField: redTextField)
        case greenSlider:
            setValueForLabel(label: greenLabel)
            setValueForTF(textField: greenTextField)
        default:
            setValueForLabel(label: blueLabel)
            setValueForTF(textField: blueTextField)
        }
        setColorForView()
    }
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(color: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    

    private func setColorForView() {
        mainView.backgroundColor = UIColor (
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func viewColorBreakDown() {
        let ciColor = CIColor(color: mainViewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValueForTF(textField: UITextField) {
        switch textField {
        case redTextField:
            textField.text = setString(slider: redSlider)
        case greenTextField:
            textField.text = setString(slider: greenSlider)
        default:
            textField.text = setString(slider: blueSlider)
        }
    }
    
    private func setValueForLabel(label: UILabel) {
        switch label {
        case redLabel:
            label.text = setString(slider: redSlider)
        case greenLabel:
            label.text = setString(slider: greenSlider)
        default:
            label.text = setString(slider: blueSlider)
        }
    }
    
    private func setString(slider: UISlider) -> String {
        String(format:"%.2f", slider.value)
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
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if let currentValue = Float(newValue) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValueForLabel(label: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValueForLabel(label: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValueForLabel(label: blueLabel)
            }
            setColorForView()
            return
        }
        //        showAlert()
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
        
        let flexibleBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        
        keyboardToolBar.items = [flexibleBarButton, doneButton]
    }
}
