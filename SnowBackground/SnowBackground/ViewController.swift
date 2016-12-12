//
//  ViewController.swift
//  SnowBackground
//
//  Created by Manuel on 11/9/16.
//  Copyright © 2016 Liip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundView : UIImageView = UIImageView()
    var emitter: CAEmitterLayer!
    var intensity: Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Background
        backgroundView.image = #imageLiteral(resourceName: "background")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Start the snowing effect
        startSnowing()
    }

    override func viewWillLayoutSubviews() {
        backgroundView.frame = self.view.frame        
    }
    
    func startSnowing() {
        emitter = CAEmitterLayer()
        
        emitter.emitterPosition = CGPoint(x: view.frame.size.width / 2.0, y: 0)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        cells.append(snowFlakeWith(color:UIColor.white))

        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }
    
    func stopSnowing() {
        emitter?.birthRate = 0
    }
    
    func snowFlakeWith(color: UIColor) -> CAEmitterCell {
        
        let image = #imageLiteral(resourceName: "flake")
        let whiteImage = image.maskWithColor(color: UIColor.white)
        
        let flake = CAEmitterCell()
        flake.birthRate = 6.0 * intensity
        flake.lifetime = 14.0 * intensity
        flake.lifetimeRange = 0
        flake.color = color.cgColor
        flake.velocity = CGFloat(350.0 * intensity)
        flake.velocityRange = CGFloat(80.0 * intensity)
        flake.emissionLongitude = CGFloat(M_PI)
        flake.emissionRange = CGFloat(M_PI_4)
        flake.spin = CGFloat(3.5 * intensity)
        flake.spinRange = CGFloat(4.0 * intensity)
        flake.scaleRange = CGFloat(intensity)
        flake.scaleSpeed = CGFloat(-0.1 * intensity)
        flake.scale = 0.2
        flake.contents = whiteImage?.cgImage
        return flake
    }
}
