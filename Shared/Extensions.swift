//
//  Extensions.swift
//  Calculator
//
//  Created by John Florian on 4/13/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import Foundation

extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

extension String {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}

extension Numeric {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}

extension Int64 {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}

extension Double {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}
