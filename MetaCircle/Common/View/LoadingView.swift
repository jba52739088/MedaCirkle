//
//  LoadingView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import UIKit

class LoadingView: UIImageView {

    override func startAnimating() {
        isHidden = false
        rotate()
    }

    override func stopAnimating() {
        isHidden = true
        removeRotation()
    }

    private func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }

    private func removeRotation() {
        layer.removeAnimation(forKey: "rotationAnimation")
    }
}
