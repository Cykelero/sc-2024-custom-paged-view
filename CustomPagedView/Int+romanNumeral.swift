//
//  Int+romanNumeral.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-19.
//

extension Int {
	// Based on https://stackoverflow.com/a/36068105
    var romanNumeral: String? {
		let mappingList = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
		
        if self >= 4000 {
			// Roman numerals cannot represent integers greater than 3999
            return nil
        }
		
		var remainingIntegerValue = self
        var numeralString = ""
        for i in mappingList {
            while remainingIntegerValue >= i.0 {
				remainingIntegerValue -= i.0
                numeralString += i.1
            }
        }
		
		return numeralString.isEmpty ? nil : numeralString
    }
}
