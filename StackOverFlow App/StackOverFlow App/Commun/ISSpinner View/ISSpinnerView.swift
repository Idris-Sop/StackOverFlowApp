//
//  ISSpinnerView.swift
//  RufTree
//
//  Created by Idris SOP on 2019/05/27.
//  Copyright © 2019 Idris SOP. All rights reserved.
//

import UIKit

class ISSpinnerView: UIView {
    
    let spinnerWidth = 75.0
    let spinnerHeight = 75.0
    override init(frame: CGRect) {
        let keyWindow = UIApplication.shared.keyWindow
        let spinnerViewFrame = CGRect(x: ((((keyWindow?.frame.origin.x)! + (keyWindow?.frame.size.width)!)/2) - CGFloat(spinnerWidth/2)), y: ((((keyWindow?.frame.origin.y)! + (keyWindow?.frame.size.height)!)/2) - CGFloat(spinnerHeight/2)), width: CGFloat(spinnerWidth), height: CGFloat(spinnerHeight))
        super.init(frame: (spinnerViewFrame))
        keyWindow?.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }
    
    override public class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    public var spinnerLineWidth: CGFloat = 3.0 {
        didSet{
            layer.lineWidth = spinnerLineWidth
        }
    }
    
    public var spinnerStrokeColor: CGColor? = UIColor.red.cgColor {
        didSet{
            layer.strokeColor = spinnerStrokeColor ?? UIColor.red.cgColor
        }
    }
    
    private var duration = 0.3
    public var spinnerDuration: CFTimeInterval = 0.3 {
        didSet{
            duration = spinnerDuration
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = spinnerStrokeColor
        layer.lineWidth = spinnerLineWidth
        setPath()
    }
    
    override public func didMoveToWindow() {
        animate()
    }
    
    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }
    
    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }
    
    private var poses: [Pose] {
        get {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(duration, 0.500, 0.5),
                Pose(duration, 1.000, 0.3),
                Pose(duration, 1.500, 0.1),
                Pose(duration, 1.875, 0.1),
                Pose(duration, 2.250, 0.3),
                Pose(duration, 2.625, 0.5),
                Pose(duration, 3.000, 0.7),
            ]
        }
    }
    
    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let poses = self.poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }
        
        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        
        animateKeyPath(keyPath: #keyPath(CAShapeLayer.strokeEnd), duration: totalSeconds, times: times, values: strokeEnds)
        
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = CAAnimationCalculationMode.linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}
