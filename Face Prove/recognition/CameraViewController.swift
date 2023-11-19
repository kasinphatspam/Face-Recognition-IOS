//
//  CameraActivity.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 18/11/2566 BE.
//

import UIKit
import SwiftUI
import Vision
import AVFoundation

struct CameraView : UIViewControllerRepresentable {
    
    @Binding var isDetected: Bool
    let base64: Binding<String>
    
    func makeCoordinator() -> Coordinator {
        Coordinator(base64Binding: base64)
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    typealias UIViewControllerType = CameraViewController
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        print("outer sheet: \(isDetected)")
        print("status: \(uiViewController.status)")
        print("count : \(uiViewController.count)")
        
        let buffer = uiViewController.count
        
        if !isDetected {
            uiViewController.count += 1
        }
        
        if !isDetected && uiViewController.status && buffer == 2 {
            // reset camera state
            uiViewController.count = 1
            uiViewController.status = false
            print("reset state")
        }
       
        print("=======================")
    }
    
}

class Coordinator: ViewControllerDelegate {
    let base64Binding: Binding<String>
    
    init(base64Binding: Binding<String>) {
        self.base64Binding = base64Binding
    }
    
    func clasificationOccured(_ viewController: CameraViewController, base64: String) {
        // whenever the view controller notifies it's delegate about receiving a new idenfifier
        // the line below will propagate the change up to SwiftUI
        base64Binding.wrappedValue = base64
    }
}

protocol ViewControllerDelegate: AnyObject {
    func clasificationOccured(_ viewController: CameraViewController, base64: String)
}

class CameraViewController: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
    
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    private var base64: String = ""
    var status: Bool = false
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCameraInput()
        showCameraFeed()
        getCameraFrames()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = view.frame
    }
    
    
    private func addCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInTrueDepthCamera, .builtInDualCamera],
            mediaType: .video, position: .back).devices.first
        else {
            fatalError("No camera detect, please use real camera not simulator")
        }
        
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        captureSession.addInput(cameraInput)
    }
    
    private func showCameraFeed() {
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }
    
    
    private func getCameraFrames() {
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        captureSession.addOutput(videoDataOutput)
        
        guard let connection = videoDataOutput.connection(with: .video), connection.isVideoRotationAngleSupported(0) else {
            return
        }
    }
    
    private func detectFace(image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest { vnRequest, error in
            DispatchQueue.main.async {
                if let result = vnRequest.results as? [VNFaceObservation], result.count > 0 {
                    self.status = true
                    let image = UIImage(ciImage: CIImage(cvPixelBuffer: image))
                    print("Detectd \(result.count) faces!")
                    print("=======================")
                    if image.base64 != nil {
                        self.base64 = image.base64!
                        self.delegate?.clasificationOccured(self, base64: self.base64)
                    }
                }
                
            }
        }
        
        let imageResultHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageResultHandler.perform([faceDetectionRequest])
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("Unable to get image from the sample buffer")
            return
        }
        
        if self.status == false {
            detectFace(image: frame)
        }
    }
    
}

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
