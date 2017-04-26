//
//  ViewController.swift
//  MMImageFilters
//
//  Created by Rachel Schneebaum on 4/5/17.
//  Copyright © 2017 Rachel Schneebaum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var originalImage: UIImage?

    @IBOutlet weak var filterImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

        originalImage = filterImageView.image
    }

    @IBAction func onAddFilterButtonTapped(_ sender: UIButton) {
        if let currentImage = filterImageView.image {
            let alertController = UIAlertController(title: "Select Filter", message: nil, preferredStyle: .actionSheet)

            let multiplyAction = UIAlertAction(title: "Multiply", style: .default, handler: { (_) in
                self.multiplyFilter(with: currentImage)
            })
            alertController.addAction(multiplyAction)

            let lightenAction = UIAlertAction(title: "Lighten", style: .default, handler: { (_) in
                self.lightenFilter(with: currentImage)
            })
            alertController.addAction(lightenAction)

            let sepiaAction = UIAlertAction(title: "Sepia", style: .default, handler: { (_) in
                self.colorFilter(with: currentImage)
            })
            alertController.addAction(sepiaAction)

            let rainbowAction = UIAlertAction(title: "Rainbow", style: .default, handler: { (_) in
                self.rainbowFilter(with: currentImage)
            })
            alertController.addAction(rainbowAction)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClearButtonTapped(_ sender: UIButton) {
        filterImageView.image = originalImage
    }


    func multiplyFilter(with image: UIImage) {
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderer = UIGraphicsImageRenderer(size: image.size)

        let result = renderer.image { (context) in
            image.draw(in: rect, blendMode: .normal, alpha: 1.0)
            image.draw(in: rect, blendMode: .multiply, alpha: 0.8)
        }

        filterImageView.image = result
    }

    func lightenFilter(with image: UIImage) {
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderer = UIGraphicsImageRenderer(size: image.size)

        let result = renderer.image { (context) in
            image.draw(in: rect, blendMode: .lighten, alpha: 0.8)
        }

        filterImageView.image = result
    }

    func colorFilter(with image: UIImage) {
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderer = UIGraphicsImageRenderer(size: image.size)

        let result = renderer.image { (context) in
            UIColor.white.set()
            context.fill(rect)

            let sepia = UIColor(red: 112/255, green: 66/255, blue: 20/255, alpha: 0.6)
            sepia.set()
            context.fill(rect)

            image.draw(in: rect, blendMode: .luminosity, alpha: 0.8)
        }

        filterImageView.image = result
    }

    func rainbowFilter(with image: UIImage) {
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderer = UIGraphicsImageRenderer(size: image.size)

        let sectionHeight = image.size.height / 6

        let red = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 0.8)
        let orange = UIColor(red: 1, green: 0.7, blue: 0.35, alpha: 0.8)
        let yellow = UIColor(red: 1, green: 0.85, blue: 0.1, alpha: 0.65)
        let green = UIColor(red: 0, green: 0.7, blue: 0.2, alpha: 0.5)
        let blue = UIColor(red: 0, green: 0.35, blue: 0.7, alpha: 0.5)
        let purple = UIColor(red: 0.3, green: 0.35, blue: 0.5, alpha: 0.6)

        let colors = [red, orange, yellow, green, blue, purple]

        let result = renderer.image { (context) in
            UIColor.white.set()
            context.fill(rect)

            for i in 0...5 {
                let color = colors[i]
                let y = CGFloat(i) * sectionHeight
                let sectionRect = CGRect(x: 0, y: y, width: image.size.width, height: sectionHeight)

                color.set()
                context.fill(sectionRect)
            }

            image.draw(in: rect, blendMode: .luminosity, alpha: 0.8)
        }

        filterImageView.image = result
    }

}

