//
//  ScannerView.swift
//  logintapSw
//
//  Created by  Александр on 06.07.2023.
//  Copyright © 2023  Александр. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct ScannerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ScannerViewController {
        return ScannerViewController()
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        // Ничего не требуется обновлять
    }
}

class ScannerViewControllerV2: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer)
            
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            if let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if metadataObject.type == AVMetadataObject.ObjectType.qr {
                    print(metadataObject.stringValue)
                }
            }
        }
    }
}
