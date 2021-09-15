//
//  ViewController.swift
//  chpanPW1
//
//  Created by teddyzxcv on 15/09/2021.
//  Copyright © 2021 teddyzxcv. All rights reserved.
//

import UIKit

// Extension for UIColor to converty HEX color to SRGB.
extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }

}

class ViewController: UIViewController {
    // Generate array of HEX cahr.
    func randomCharacter() -> String? {
        let numbers = [0,1,2,3,4,5,6, 7, 8, 9]
        let letters = ["A","B","C","D","E","F"]
        
        let numberOrLetter = arc4random_uniform(2)
        
        switch numberOrLetter {
        case 0: return String(numbers[Int(arc4random_uniform(10))])
        case 1: return letters[Int(arc4random_uniform(6))]
        default: return nil
        }
    }
    // Combine the array to string.
    func characterArrayToHexString(array: [String]) -> String {
        var hexString = ""
        for character in array {
            hexString += character
        }
        return hexString
    }
    
    // Generate a random color in HEX
    func generateRandomColor() -> String {
        var characterArray: [String] = []
        for _ in 0...5 {
            characterArray.append(randomCharacter()!)
        }
        return characterArrayToHexString(array: characterArray)
    }
    @IBOutlet var views: [UIView]!
    
    @IBOutlet weak var changeColorButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        var set = Set<UIColor>()
        // UIColor(
        // red: .random(in : 0...1),
        // green: .random(in : 0...1),
        // blue: .random(in : 0...1),
        // alpha: 1)
        while set.count < views.count {
            let colorInHex = generateRandomColor()
            set.insert(UIColor(hex: Int(colorInHex, radix: 16)!))
            print(UIColor(hex: Int(colorInHex, radix: 16)!))
        }
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                view.layer.cornerRadius = 10;
                view.backgroundColor = set.popFirst()
            }
        }) {completion in
            button?.isEnabled = true
        }
    }
    
    
    
}

