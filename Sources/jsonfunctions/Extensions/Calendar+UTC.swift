//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

extension Calendar {

    static var utc: Calendar {
        guard let utc = TimeZone(identifier: "UTC") else {
            return Calendar.current
        }

        var tmpCalendar = Calendar(identifier: .gregorian)
        tmpCalendar.timeZone = utc

        return tmpCalendar
    }
    
}
