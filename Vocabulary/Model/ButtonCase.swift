//
//  ButtonCase.swift
//  Vocabulary
//
//  Created by 陳佩琪 on 2023/8/15.
//

import Foundation

enum ButtonName: String {
    case submit, next
    
    var nameString: String {
        switch self {
        case .submit:
            return "Submit"
        case . next:
            return "Next"
        }
    }
    
    
}
