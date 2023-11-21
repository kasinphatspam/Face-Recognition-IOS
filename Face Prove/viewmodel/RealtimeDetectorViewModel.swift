//
//  RealtimeDetectorViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 21/11/2566 BE.
//

import Foundation

class RealtimeDetectorViewModel: ObservableObject {
    
    private let recognitionService: RecognitionService = RecognitionService()
    var signal: Observable<Signals> = Observable(Signals(command: ""))
    var result: Observable<RecognitionResponse> = Observable(nil)
    
    func reconize(image: String) async throws {
        try await recognitionService.recognize(image: image) {
            error, success, data in
            if error != nil {
                self.signal.value = Signals(command: "RECOGNITION_FAILED")
                return
            }
            
            if success {
                if data?.statusCode == -1 {
                    self.signal.value = Signals(command: "RECOGNITION_NOT_FOUND_FACE")
                    print("RecognitionService: Not found face")
                    return
                }
                
                if data?.statusCode == 0 {
                    self.signal.value = Signals(command: "RECOGNITION_UNKNOWN")
                    print("RecognitionService: Unknown")
                    return
                }
                
                if data?.statusCode == 500 {
                    self.signal.value = Signals(command: "RECOGNITION_CANNOT_CONNECT_TO_SERVER")
                    print("RecognitionService: Cannot connect to server")
                    return
                }
                
                self.result.value = data
                self.signal.value = Signals(command: "RECOGNITION_COMPLETED")
                print("RecognitionService: Found customer information")
            }
        }
    }
}
