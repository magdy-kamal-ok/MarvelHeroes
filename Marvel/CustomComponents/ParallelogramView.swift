//
//  File.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class ParallelogramView: UIView {
    
    @IBInspectable var offset:    CGFloat = 20        { didSet { setNeedsDisplay() } }
    @IBInspectable var fillColor: UIColor = .white      { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: bounds.minX + offset, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - offset, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        
        // Close the path. This will create the last line automatically.
        path.close()
        fillColor.setFill()
        path.fill()
    }
    
}
