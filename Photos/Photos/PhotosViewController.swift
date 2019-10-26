//
//  PhotosViewController.swift
//  Photos
//
//  Created by Cassidy Pelchat on 10/25/19.
//  Copyright © 2019 Cassidy Pelchat. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photoDisplayed: UIImageView!
    var imageData: NSData!
    @IBOutlet weak var photoTitle: UINavigationItem!
    @IBOutlet weak var titleOfPhoto: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var images = [ImageDetails]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTitle.title = ""
        titleOfPhoto.text = nil
        titleOfPhoto.isEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func importPhoto(_ sender: Any) {
        
        let photo = UIImagePickerController()
        photo.delegate = self
        
        photo.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        photo.allowsEditing = false
        
        self.present(photo, animated: true, completion: nil)
        
        
    }
    
    @IBAction func deletePhoto(_ sender: Any) {
        if photoDisplayed == nil {
            alertNotifyUser(message: "There is no photo to delete.")
        }
        else {
            photoDisplayed.image = nil
            titleOfPhoto.text = ""
            alertNotifyUser(message: "The photo has been deleted.")
            titleOfPhoto.isEnabled = false
        }
    }
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
        let photo = UIImagePickerController()
        photo.delegate = self
        
        photo.sourceType = UIImagePickerControllerSourceType.camera
        
        photo.allowsEditing = false
        
        self.present(photo, animated: true, completion: nil)
    }
        else {
             alertNotifyUser(message: "This device does not have a camera.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            photoDisplayed.image = photo
            imageData = UIImagePNGRepresentation(photo)! as NSData
            titleOfPhoto.isEnabled = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "ImageDetails", into: context)

            newPhoto.setValue(imageData, forKey: "imageData")
            
            do
            {
                try context.save()
            }
            catch {
                alertNotifyUser(message: "Your data could not be saved!")
            }
            
        }
        else {
             alertNotifyUser(message: "The image was not imported successfully!")
        }
        self.dismiss(animated: true, completion: nil)
        
        
    
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
            (alertAction) -> Void in
            print("OK selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func savePhoto(_ sender: UIBarButtonItem) {
        
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "ImageDetails", into: context)


           newPhoto.setValue(titleOfPhoto.text, forKey: "title")
            
            do
            {
                try context.save()
            }
            catch {
                alertNotifyUser(message: "Your data could not be saved!")
            }
            
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
