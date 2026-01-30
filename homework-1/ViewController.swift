//
//  ViewController.swift
//  homework-1
//
//  Created by Bakberdi Esentai on 30.01.2026.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let celsiusTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.text = "0"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let fahrenheitTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel = TemperatureViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Temperature Converter"
        setupUI()
        setupBindings()
        setupActions()
        
        celsiusTextField.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(celsiusTextField)
        view.addSubview(fahrenheitTextField)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            celsiusTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            celsiusTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            celsiusTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            fahrenheitTextField.topAnchor.constraint(equalTo: celsiusTextField.bottomAnchor, constant: 20),
            fahrenheitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            fahrenheitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            resetButton.topAnchor.constraint(equalTo: fahrenheitTextField.bottomAnchor, constant: 10),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupBindings() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: celsiusTextField)
            .compactMap { ($0.object as? UITextField)?.text }
            .assign(to: \.celsiusText, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$fahrenheitText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fahrenheitValue in
                self?.fahrenheitTextField.text = fahrenheitValue
            }
            .store(in: &cancellables)
        
        viewModel.$celsiusText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] celsiusValue in
                if self?.celsiusTextField.text != celsiusValue {
                    self?.celsiusTextField.text = celsiusValue
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupActions() {
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc private func resetButtonTapped() {
        viewModel.reset()
        dismissKeyboard()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let decimalCount = updatedText.filter { $0 == "." }.count
        if decimalCount > 1 {
            return false
        }
        
        return true
    }
}

