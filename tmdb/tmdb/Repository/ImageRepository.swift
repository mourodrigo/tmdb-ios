//  ImageRepository.swift
//  tmdb

import Foundation
import Alamofire
import AlamofireImage

protocol ImageRepository {
    func getImage(for: URL, onSuccess: @escaping (_ image: UIImage, _ url: URL) -> Void, onError: @escaping  ErrorClosure)
}

class AFImageRepository: ImageRepository {

    private var _cache = [URL: UIImage]() //the most simplest cache ever

    func getImage(for url: URL, onSuccess: @escaping  (_ image: UIImage, _ url: URL) -> Void, onError: @escaping ErrorClosure) {

        if let cachedImage =  _cache[url] {
            onSuccess(cachedImage, url)
            return
        }

        AF.request(url).responseImage { response in

            if case .success(let image) = response.result {
                self._cache[url] = image
                onSuccess(image, url)
                return
            }

            if let error = response.error {
                onError(error)
            }
        }

        
    }

}
