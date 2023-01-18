//
//  RangeIntegerStyle.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 1/17/23.
//

import SwiftUI

// many thanks to Antoine van der Lee for this strategy:
// https://www.avanderlee.com/swiftui/formatstyle-formatter-restrict-textfield-input/
struct RangeIntegerStyle: ParseableFormatStyle {

    var parseStrategy: RangeIntegerStrategy
    let range: ClosedRange<Int>

    init(range: ClosedRange<Int>, defaultValue: Int) {
        self.range = range
        self.parseStrategy = RangeIntegerStrategy(defaultValue: defaultValue)
    }
    
    func format(_ value: Int) -> String {
        let constrainedValue = min(max(value, range.lowerBound), range.upperBound)
        return "\(constrainedValue)"
    }
}

struct RangeIntegerStrategy: ParseStrategy {
    let defaultValue: Int
    func parse(_ value: String) throws -> Int {
        return Int(value) ?? defaultValue
    }
}

extension FormatStyle where Self == RangeIntegerStyle {
    static func ranged(_ range: ClosedRange<Int>, defaultValue: Int = 1) -> RangeIntegerStyle {
        return RangeIntegerStyle(range: range, defaultValue: defaultValue)
    }
}
