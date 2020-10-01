//
//  ViewController.swift
//  test
//
//  Created by Miles Chou on 2020/9/29.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var Imageshow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Thread.sleep(forTimeInterval: 3.0)
    }


    @IBAction func TakeSelfie(_ sender: Any) {
        //self.Imageshow.image = UIImage(named: "picture1")
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;  //imagePicker delegate to self object which is the current view controller
        if UIImagePickerController.isSourceTypeAvailable(.camera) { //check if camera is avalable
            imagePicker.sourceType = .camera;
            if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
                imagePicker.cameraDevice = .rear
            } else {
                imagePicker.cameraDevice = .front
            }
        } else {
            imagePicker.sourceType = .photoLibrary
        }

        self.present(imagePicker, animated: true, completion: nil) //present the view controller
    }
    
    //which gets called by the image picker when an image was selected.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            Imageshow.image = image
        } else {
            print("No Image Found!")
        }
        self.dismiss(animated: true, completion: nil)//remove the view controller that was presented
    }
    
    @IBAction func ShowAllPhotos(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum //set the source type
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)//present the view controller
    }

    @IBAction func SavePhoto(_ sender: Any) {
        guard let image = Imageshow.image else {  //get the image from ImageShow object
            print("No Image Saved!")
            let alertController = UIAlertController(title: "Error", message: "No Image Saved!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) //save image to album
        Imageshow.image = nil
        
        let alertController1 = UIAlertController(title: "Saved Successfully!", message: nil, preferredStyle: .alert)
        self.present(alertController1, animated: true, completion: nil) //present alert window
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        } //two seconds dispear automatically
    }
}

