//
//  FormViewController.swift
//  Me
//
//  Created by NDPhu on 7/1/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import YPImagePicker
import Firebase

class FormViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    var items = [YPMediaItem]()
    var urlImages = [String]()
    var account: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.shared.getAccountFromFaceBook { [weak self] (account) in
            guard let weakSELF = self else {return}
            weakSELF.account = account
        }
        contentTextView.placeholder = "Bạn đang nghĩ gì ..."
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        postImageView.layer.cornerRadius = 5
        contentTextView.layer.cornerRadius = 5
        contentTextView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<items.count {
            switch items[i] {
            case .photo(let photo):
                if i == 0 { postImageView.image = photo.image }
                uploadImnge(image: photo.image)
            default:
                return
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func post(_ sender: UIButton) {
        if self.urlImages.count != 0 {
            uploadPost(account: account, urlImages: self.urlImages, idPost: Int32.random(in: 1000000...9999999), timeStamp: Date().convertDateToTimeInterval(), content: contentTextView.text, location: "Hà Nội")
        }
    }
    
    func uploadPost(account: Account, urlImages: [String],idPost: Int32, timeStamp: TimeInterval,content: String,location: String) {
        if let id = account.id , let name = account.name , let picture = account.picture {
            let parameter = ["urlAvatar":picture.data.url,"idAccount":id,"idPost":"\(idPost)","timeStamp":timeStamp, "nameAccount":name,"content":content,"urlImages":urlImages,"location":location] as [String : Any]
            let database = Database.database().reference().child("posts").childByAutoId()
            database.setValue(parameter) { [weak self] (err, databaseRef) in
                if err != nil {
                    print(err!)
                } else {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func uploadImnge(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.5) {
            let imagesRef = Storage.storage().reference().child("images").child("image").child("product")
            let ref = imagesRef.child("\(Int32.random(in: 1000000...9999999)).jpg")
            let _ = ref.putData(data, metadata: nil) { [weak self] (metadata, error) in
                if let strongSELF = self, error == nil {
                    // You can also access to download URL after upload.
                    ref.downloadURL { (url, error) in
                        guard let downloadURL = url else { return }
                        strongSELF.urlImages.append("\(downloadURL)")
                    }
                } else {
                    print(error!)
                }
            }
        }
    }
}

extension UITextView :UITextViewDelegate
{

    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }

    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?

            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }

            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }

    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }

    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }

    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()

        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()

        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100

        placeholderLabel.isHidden = self.text.count > 0
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}
