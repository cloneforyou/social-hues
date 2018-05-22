//
//  PromptViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/21/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit
import AVFoundation

class PromptViewController: UIViewController {
    weak var delegate: ConvoPageViewController?
    @IBOutlet weak var scannedLabel: UILabel!
    @IBOutlet weak var qrBoundary: UIImageView!
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var hold: UILabel!
    @IBOutlet weak var slideUp: UILabel!
    
    @IBOutlet weak var slideDown: UILabel!
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterQRMode(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            self.prompt.isHidden = true
            self.hold.isHidden = true
            
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
            self.videoPreviewLayer?.isHidden = false
            
            displayOrScan(touchLoc: sender.location(in: self.view))
        } else if sender.state == .changed {
            displayOrScan(touchLoc: sender.location(in: self.view))
        } else if sender.state == .ended {
            self.scannedLabel.isHidden = true
            self.qrBoundary.isHidden = true
            self.prompt.isHidden = false
            self.hold.isHidden = false
            self.videoPreviewLayer?.isHidden = true
            self.slideDown.isHidden = true
            self.slideUp.isHidden = true
            self.qrCodeFrameView?.isHidden = true
            
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }
    
    private func displayOrScan(touchLoc: CGPoint) {
        if touchLoc.y < self.view.bounds.height - 95 {
            // scan mode
            self.slideDown.isHidden = false
            self.slideUp.isHidden = true
            self.qrCodeFrameView?.isHidden = false
            self.scannedLabel.isHidden = true
            self.qrBoundary.isHidden = true
        } else {
            // display mode
            self.slideUp.isHidden = false
            self.slideDown.isHidden = true
            self.qrCodeFrameView?.isHidden = true
            self.scannedLabel.isHidden = false
            self.qrBoundary.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scannedLabel.isHidden = true
        self.qrBoundary.isHidden = true
        self.prompt.isHidden = false
        self.hold.isHidden = false
        self.slideUp.isHidden = true
        self.slideDown.isHidden = true
        
        
        var deviceDiscoverySession: AVCaptureDevice.DiscoverySession
        if AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) != nil {
            deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back)
        } else {
            deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        }
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            captureSession.addOutput(output)
            
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = [.qr]
        } catch {
            print(error)
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = self.view.bounds
        videoPreviewLayer?.isHidden = true
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            qrCodeFrameView.isHidden = true
            view.addSubview(qrCodeFrameView)
            
        }
        
        self.view.layer.addSublayer(videoPreviewLayer!)
        self.view.bringSubview(toFront: self.qrCodeFrameView!)
        self.view.bringSubview(toFront: self.qrBoundary)
        self.view.bringSubview(toFront: self.scannedLabel)
        self.view.bringSubview(toFront: self.slideDown)
        self.view.bringSubview(toFront: self.slideUp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}

extension PromptViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == .qr {
            let qrObj = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = qrObj!.bounds
        }
    }
}
