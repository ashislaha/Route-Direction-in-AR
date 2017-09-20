# Route-Direction-in-AR

iTunes link : https://itunes.apple.com/us/app/route-direction-ar/id1284255454?ls=1&mt=8

Adding the Feature "Real World Path Direction" by tapping on Map. GoogleMap will give us the direction to that location from user location then click on "ARView" & you will get the real-world path direction.

Also added "Reachability" for finding path in Google map.

-- Also added .mlmodel for car-detection. Initially trained the model using Convolutional Neural Network in TensorFlow, then convert the .h5 output into .mlmodel. Use it in the application. please check : https://github.com/ashislaha/CarDetection-Keras & https://github.com/ashislaha/CarDetection-iOS for more details how to train a model.

-- In ARFrame generates capturedImage which is the input to .mlmodel for detecting that car is present in the image or not.

-- This project combines both ARKit & CoreML.
