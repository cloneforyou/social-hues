//
//  PromptViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/21/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit
import AVFoundation

protocol PromptViewControllerDelegate: class {
    func updateTimeLabel(time: Int)
    func startNewPrompt(_ newColor: UIColor, newPrompt: String)
}

class PromptViewController: UIViewController {
    weak var delegate: ConvoPageViewController?
    var timer: Timer?
    var event: Event?
    @IBOutlet weak var scannedLabel: UILabel!
    @IBOutlet weak var qrBoundary: UIImageView!
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var hold: UILabel!
    @IBOutlet weak var slideUp: UILabel!
    @IBOutlet weak var partner: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var slideDown: UILabel!
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    weak var data = InMemData.getData()
    weak var icebreaker: Icebreaker?
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        addDelegate()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        addDelegate()
//    }
    
    func addDelegateToIcebreaker() {
        guard let code = event?.code, let icebreaker = data?.icebreakers[code] else {
            print("could not find code or icebreaker")
            return
        }
        self.icebreaker = icebreaker
        self.icebreaker?.delegate = self
    }

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
            self.partner?.isHidden = true
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
            // display mode
            self.slideUp.isHidden = true
            self.slideDown.isHidden = false
            self.qrCodeFrameView?.isHidden = true
            self.scannedLabel.isHidden = true
            self.partner?.isHidden = true
            self.qrBoundary.isHidden = false
        } else {
            self.slideDown.isHidden = true
            self.slideUp.isHidden = false
            
            if self.icebreaker?.havePartner == true {
                self.scannedLabel.isHidden = false
                self.partner?.isHidden = false
            }
            self.qrCodeFrameView?.isHidden = false
            
            self.qrBoundary.isHidden = true
            // scan mode
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let code = event?.code, let data = data, let icebreaker = data.icebreakers[code] else {
            print("could not find code or icebreaker")
            return
        }
        self.view.backgroundColor = icebreaker.currColor
        self.timerLabel.text = String(icebreaker.currTimeLeft)
        self.prompt.text = event?.prompts[icebreaker.currPromptIndex]
        
        if (self.icebreaker?.havePartner)! {
            self.partner.text = "Speaking to " + (self.icebreaker?.partnerName)!
        }

        // Do any additional setup after loading the view.
        self.scannedLabel.isHidden = true
        self.qrBoundary.isHidden = true
        self.prompt.isHidden = false
        self.prompt.transform = self.prompt.transform.rotated(by: .pi)
        self.hold.isHidden = false
        self.slideUp.isHidden = true
        self.slideDown.isHidden = true
        
        // configure qr boundary with new QR
        self.qrBoundary.backgroundColor = .lightText
        let w = qrBoundary.bounds.width * 0.6
        let h = qrBoundary.bounds.height * 0.6
        
        let qrData = self.data?.me?.qrString().data(using: .isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(qrData, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        let qrCodeImage = filter?.outputImage
        let scaleX = w / (qrCodeImage?.extent.size.width)!
        let scaleY = h / (qrCodeImage?.extent.size.height)!
        
        
        let qrImage = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        qrImage.image = UIImage(ciImage: (qrCodeImage?.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY)))!)
        qrImage.translatesAutoresizingMaskIntoConstraints = true
        qrImage.center = CGPoint(x: self.qrBoundary.bounds.midX, y: self.qrBoundary.bounds.midY)
        qrImage.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        qrBoundary.addSubview(qrImage)
        
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
        
        
        partner?.isHidden = true
        partner?.backgroundColor = .lightText
        
        
        
        self.view.layer.addSublayer(videoPreviewLayer!)
        self.view.bringSubview(toFront: self.qrCodeFrameView!)
        self.view.bringSubview(toFront: self.qrBoundary)
        self.view.bringSubview(toFront: self.scannedLabel)
        self.view.bringSubview(toFront: self.partner!)
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
            
            if metadataObj.stringValue != nil {
                if Contact.isContactString(qrString: metadataObj.stringValue!) && !(self.icebreaker?.havePartner)! {
                    //self.qrCodeFrameView?.isHidden = true
                    self.scannedLabel.isHidden = false
                    //print(metadataObj.stringValue!)
                    let newFriend = Contact(qrString: metadataObj.stringValue!)
                    data?.friends.append(newFriend)
                    self.partner?.text = "Speaking to " + newFriend.firstName
                    self.partner?.isHidden = false
                    self.icebreaker?.startTimer(name: newFriend.firstName)
                }
                
            }
        }
    }
}

extension PromptViewController: PromptViewControllerDelegate {
    func updateTimeLabel(time: Int) {
        self.timerLabel.text = String(time)
    }
    
    func startNewPrompt(_ newColor: UIColor, newPrompt: String) {
        self.view.backgroundColor = newColor
        self.prompt.text = newPrompt
        self.scannedLabel.isHidden = true
        self.partner.isHidden = true
    }
}
