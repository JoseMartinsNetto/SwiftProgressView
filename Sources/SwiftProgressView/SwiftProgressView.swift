//
//  ProgressView.swift
//  CircularProgressViewPOC
//
//  Created by Jose Martins on 30/08/21.
//

#if canImport(UIKit)

import UIKit

@IBDesignable public class ProgressView: UIView {
    
    private lazy var trackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.lineWidth = progressWidth
        trackLayer.strokeColor = trackColor?.cgColor
        trackLayer.fillColor = nil
        trackLayer.frame = bounds
        trackLayer.strokeEnd = 1

        return trackLayer
    }()
    
    private lazy var progressLayer: CAShapeLayer = {
        let progress = CAShapeLayer()
        progress.lineWidth = progressWidth
        progress.strokeColor = progressColor?.cgColor
        progress.frame = bounds
        progress.fillColor = nil
        progress.strokeEnd = 0
        progress.lineCap = .round

        return progress
    }()
    
    @IBInspectable public var progressWidth: CGFloat = 10 {
        didSet {
            progressLayer.lineWidth = progressWidth
            trackLayer.lineWidth = progressWidth
        }
    }
    
    @IBInspectable public var trackColor: UIColor? = .clear {
        didSet {
            trackLayer.strokeColor = trackColor?.cgColor
        }
    }
    
    @IBInspectable public var progressColor: UIColor? = .lightGray {
        didSet {
            progressLayer.strokeColor = progressColor?.cgColor
        }
    }
    
    private(set) public var currentProgress: CGFloat = 0
    private(set) public var currentPercentText: String = "0%"
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if self.layer.cornerRadius > 0 {
            trackLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            progressLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        }else{
            trackLayer.path = UIBezierPath(rect: bounds).cgPath
            progressLayer.path = UIBezierPath(rect: bounds).cgPath
        }
        
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }
    
    public func setProgress(_ value: CGFloat) {
        guard value <= 1 && value >= 0 else { return }
        
        if progressLayer.strokeEnd < 1 {
            progressLayer.strokeEnd = value
            currentProgress = progressLayer.strokeEnd
            currentPercentText = "\(Int(progressLayer.strokeEnd * 100))%"
        }
    }
    
    public func increaseProgress(_ value: CGFloat) {
        guard progressLayer.strokeEnd <= 1 else { return }
        
        progressLayer.strokeEnd += value
        
        currentProgress = progressLayer.strokeEnd
        currentPercentText = "\(Int(progressLayer.strokeEnd * 100))%"
    }
    
    public func decreaseProgress(_ value: CGFloat) {
        guard progressLayer.strokeEnd >= 0 else { return }
        
        progressLayer.strokeEnd -= value
        
        currentProgress = progressLayer.strokeEnd
        currentPercentText = "\(Int(progressLayer.strokeEnd * 100))%"
    }
}

#endif
