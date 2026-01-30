//
//  TemperatureViewModel.swift
//  homework-1
//
//  Created by Bakberdi Esentai on 30.01.2026.
//

import Foundation
import Combine

class TemperatureViewModel {
    @Published var celsiusText: String = "0"
    @Published var fahrenheitText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $celsiusText
            .map { [weak self] celsiusString -> String in
                guard let self = self,
                      !celsiusString.isEmpty,
                      let celsius = Double(celsiusString) else {
                    return ""
                }
                return self.convertToFahrenheit(celsius: celsius)
            }
            .assign(to: &$fahrenheitText)
    }
    
    private func convertToFahrenheit(celsius: Double) -> String {
        let fahrenheit = (celsius * 9/5) + 32
        return String(format: "%.2f", fahrenheit)
    }
    
    func reset() {
        celsiusText = "0"
        fahrenheitText = ""
    }
}
