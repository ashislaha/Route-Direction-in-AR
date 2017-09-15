//
//  Classification.swift
//  ARDemo
//
//  Created by Ashis Laha on 21/08/17.
//  Copyright © 2017 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit
import CoreML

enum Classifier {
    case DNN
    case CNN
}

enum Classes {
    case CAR
    case NON_CAR
}

class ImageClassification {
    
    //MARK:- Classification
    
    class func classify(image : UIImage?, classifier : Classifier = .CNN , row : Int = 100, column : Int = 100, classes : Int = 2) -> Classes {
        
        guard let image = image else { return .NON_CAR }
        let imageInfo : (image : UIImage, pixel: [Double]) = ImagePreProcessing.shared.preProcessImage(image: image)
        
        
        if classifier == .DNN {
            let mlModel = car_detection_keras_DNN()    // Input Matrix is [10000] Matrix - 1D Matrix
            guard let inputMatrix = try? MLMultiArray(shape: [10000], dataType: .double) else { fatalError("Unexpected runtime error. MLMultiArray") }
            
            // Feed data to inputMatrix
            for i in 0..<row*column { inputMatrix[i] = NSNumber(value: imageInfo.pixel[i]) }
            
            if let prediction = try? mlModel.prediction(input1: inputMatrix) {
                let outputs = prediction.output1
                print(outputs)
                var outputArray = [Double]()
                for i in 0..<classes { outputArray.append(Double(truncating: outputs[i])) }
                return outputArray[0] > outputArray[1] ?  .CAR : .NON_CAR
            }
        } else if classifier == .CNN {
            let mlModel = car_detection_keras_CNN() // Input Matrix is [1, 100, 100] Matrix - 1D Matrix
            
            guard let inputMatrix = try? MLMultiArray(shape: [1,100,100], dataType: .double) else { fatalError("Unexpected runtime error. MLMultiArray") }
            
            // Feed data to inputMatrix
            for i in 0..<row*column { inputMatrix[i] = NSNumber(value: imageInfo.pixel[i]) }
            
            if let prediction = try? mlModel.prediction(input1: inputMatrix) {
                let outputs = prediction.output1
                print(outputs)
                var outputArray = [Double]()
                for i in 0..<classes { outputArray.append(Double(truncating: outputs[i])) }
                return outputArray[0] > outputArray[1] ?  .CAR : .NON_CAR
            }
        }
        return .NON_CAR
    }
}
