//
//  LoginVC.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/29/23.
//

import UIKit


import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage
import SwiftUI


class LoginVC: UIViewController {
    
    @IBOutlet weak var Username_Txt: UITextField!
    @IBOutlet weak var email_Txt: UITextField!
    
    @IBOutlet weak var user_Img: UIImageView!
    
    @IBOutlet weak var login_But: UIButton!
    
   // @AppStorage("signIn") var isSignIn = false
    
    
    
  //  animation
    
    @IBOutlet weak var LeftUserName: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var rightUserName: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightView: UIView!
    
   //. @IBOutlet weak var startButton: UIButton!
    
   // var isSignIn = Foundation.UserDefaults.standard.bool(forKey: "signIn")
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let isSignIn = UserDefaults.standard.bool(forKey: "signIn")
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let Img = UserDefaults.standard.string(forKey: "userimg") ?? ""
        let emailID = UserDefaults.standard.string(forKey: "emailID") ?? ""
        
        
        self.leftImageView.layer.cornerRadius = leftImageView.frame.height/2
        self.leftView.roundCorners(corners: [.topLeft, .bottomLeft], radius: leftView.frame.height/2)
        
        self.rightImageView.layer.cornerRadius = rightImageView.frame.height/2
        self.rightView.roundCorners(corners: [.topRight, .bottomRight], radius: rightView.frame.height/2)
        
        if !isSignIn {
          
            
         
         
          
        } else {
           
            
            self.updateView(img: Img, name: username, email:emailID )
            
          
            
            LeftUserName.text = username
            rightUserName.text = username
            
            var leftFrame = leftView.frame
            leftFrame.origin.x = 400
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
                self.leftView.frame = leftFrame
                
            })
            
            var rightFrame = leftView.frame
            rightFrame.origin.x = -400
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
                self.rightView.frame = rightFrame
                
            })
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.navigate_TO(id: "HomeVC")
            })
        
        
            
          
            
            
        }
        
       
        
        user_Img.layer.cornerRadius = user_Img.frame.width/2
        user_Img.layer.borderWidth = 2
        user_Img.layer.borderColor = UIColor.lightGray.cgColor
        
        email_Txt.layer.borderWidth = 2
        email_Txt.layer.cornerRadius = 10
        email_Txt.layer.borderColor = UIColor.lightGray.cgColor
        
        Username_Txt.layer.borderWidth = 2
        Username_Txt.layer.cornerRadius = 10
        Username_Txt.layer.borderColor = UIColor.lightGray.cgColor
        
        login_But.layer.borderWidth = 2
        login_But.layer.cornerRadius = 10
        login_But.layer.borderColor = UIColor.lightGray.cgColor
   
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let isSignIn = UserDefaults.standard.bool(forKey: "signIn")
        
        if !isSignIn {
          
            login_But.setTitle("LOGIN", for: .normal)
         
          
        } else {
      
            login_But.setTitle("LOGOUT", for: .normal)
            
            
        }
    }

    
    @IBAction func signin_Action(_ sender: Any) {
 
        let isSignIn = UserDefaults.standard.bool(forKey: "signIn")
        
        if !isSignIn {
          
            createAuthcredential()
          
            
          
        } else {
      
            login_But.setTitle("LOGIN", for: .normal)
         
            
            if let appDomain = Bundle.main.bundleIdentifier {
               UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            UserDefaults.standard.set(false, forKey: "signIn")
            UserDefaults.standard.setValue(nil, forKey: "username")
            UserDefaults.standard.setValue(nil, forKey: "userimg")
            UserDefaults.standard.setValue(nil, forKey: "emailID")
            
            
            Username_Txt.text = ""
            email_Txt.text = ""
            
            LeftUserName.text = ""
            rightUserName.text = ""
            
            user_Img.image = UIImage(named: "")
  
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
             // print("Error signing out: %@", signOutError)
            }
            
            
        }
        
       
 
    }
    
    func createAuthcredential(){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              
          return
              
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
           return
          }

          let Credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
            
            
            
            Auth.auth().signIn(with: Credential) { result, error in

                let username = result?.user.displayName ?? ""
                let emailID = result?.user.email ?? ""
                
                let userimg = result?.user.photoURL
                
                
                
                UserDefaults.standard.set(true, forKey: "signIn")
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set("\(userimg)", forKey: "userimg")
                UserDefaults.standard.set(emailID, forKey: "emailID")
                
                self.login_But.setTitle("LOGOUT", for: .normal)
   
                self.updateView(img: "\(String(describing: userimg!))", name: username, email:emailID )
                
                
                var leftFrame = self.leftView.frame
                leftFrame.origin.x = 400
                UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
                    self.leftView.frame = leftFrame
                    
                })
                
                var rightFrame = self.leftView.frame
                rightFrame.origin.x = -400
                UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
                    self.rightView.frame = rightFrame
                    
                })
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.navigate_TO(id: "HomeVC")
                })
                
               
            }
            
            
        
        }
        
        
    }

    
    func updateView(img: String, name: String, email: String) {
        

        if let Url = URL(string: img) {
            
            downloadImage(url: Url)
        }
        
      
        
        Username_Txt.text = name
        email_Txt.text = email
        
        LeftUserName.text = name
        rightUserName.text = name
        
        uploadMedia(url: img)
        
        
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.user_Img.image = UIImage(data: data)
         
                
            }
            
            
        }
    }
    
    
    
    func uploadMedia(url: String?) {

       let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser?.uid ?? "").png")
       if let uploadData = self.user_Img.image?.jpegData(compressionQuality: 0.5) {
           storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
               if error != nil {
                   print("error")
                 //  completion(nil)
               } else {

                   storageRef.downloadURL(completion: { (url, error) in

                       print(url?.absoluteString)
                    
                   })

               


               }
           }
       }
   }
    
    

    
}


extension UIView {
    /*Set Corner for selected Edge*/
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

