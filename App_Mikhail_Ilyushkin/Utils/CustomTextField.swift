//
//  CustomTextField.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 16.12.2020.
//

import UIKit

class CustomTextField: UITextField {
    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        
        super.init(frame: .zero)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
