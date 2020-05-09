//
//  CountryStat.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

struct CountryStat {
    var code: String?
    var name: String?
    var confirmed: Int?
    var deaths: Int?
    var recovered: Int?
    var flagImage: UIImage?
}

extension CountryStat: Equatable {}

func == (lhs: CountryStat, rhs: CountryStat) -> Bool {
    return lhs.code == rhs.code
}
