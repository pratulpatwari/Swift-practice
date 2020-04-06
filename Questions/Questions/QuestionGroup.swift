//
//  QuestionGroup.swift
//  Questions
//
//  Created by pratul patwari on 6/2/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import Foundation

struct QuestionGroup : Decodable {
    let question: String
    let options: [Options]
}
