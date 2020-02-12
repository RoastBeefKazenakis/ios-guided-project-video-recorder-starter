//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		//  Get permission
		
        requestPermissionAndShowCamera()
	
		
	}
	
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status{
        case .notDetermined:// first use of the app
            requestVideoPermission()
        
        case .restricted:
            fatalError("Video is disabled, please review parental controls")
        
        case .authorized: //user previously gave permission, we can show the camera
            showCamera()
            
        case .denied:
            fatalError("We asked for permission, they said no")
            
        @unknown default:
            fatalError("a new status code was added that we need to handle")
        }
        
    }
    
    private func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("TELL USER TO EBMABLE PREmISSION FOR VIDEO/CAMERA")
            }
            //Show Camera
            DispatchQueue.main.async {
                self.showCamera()
            }
            
        }
    }
    
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
