//
//  ProfileViewModelNameAndPictureItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class ProfileViewModelNameAndPictureItem: CustomViewModelItem {
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    var sectionTitle: String {
        return ""
    }
    var pictureUrl: String?{
        didSet{
            print("image did set")
        }
    }
    
    var userName: String
    var fullName: String
    var userID: Int
    
    var  task :  AnyCancellable?  =  nil
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    var imgData: Data?
    
    init(pictureUrl: String?, userName: String, fullName: String, userID: Int) {
        self.pictureUrl = pictureUrl
        self.userName = userName
        self.fullName = fullName
        self.userID = userID
    }
    
       func uploadPhoto(_ imagedata: Data, params: [String : Any]?, completion: @escaping (User) -> ()) {
       
//        -F "file=@star_filled.png;type=image/png"
        let url = "http://3ichtounsi.apis.demo.proxym-it.net/pic/user/\(userID)"

        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = [
            "Content-type" : "multipart/form-data","Authorization" : "Bearer \(token)"
        ]
        AF.upload(multipartFormData: { multiPart in
           multiPart.append(imagedata, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url, method: .post, headers: header) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                print("upload success result: \(resut)")
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
}

