//
//  ViewController.swift
//  Scanner
//
//  Created by Michael Lyon Gardiner on 7/30/18.
//  Copyright © 2018 Proxilink, Inc. All rights reserved.
//

import UIKit
import WeScan

class ViewController: UIViewController, ImageScannerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func scan(_ sender: UIButton) {
        if #available(iOS 10, *) {
            let scannerVC = ImageScannerController()
            scannerVC.imageScannerDelegate = self
            self.present(scannerVC, animated: true, completion: nil)
        } else {
            // if user has less than ios 10 installed
        }
    }
    
    // Somewhere on your ViewController that conforms to ImageScannerControllerDelegate
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // Your ViewController is responsible for dismissing the ImageScannerController
        imageView.image = results.scannedImage
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // Your ViewController is responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true, completion: nil)
    }
}

