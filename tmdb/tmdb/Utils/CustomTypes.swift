//  CustomTypes.swift
//  tmdb

import Foundation

//*************************************************
// MARK: - Wrapper
//*************************************************

typealias JSON = [String: Any]

typealias VoidClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

//TODO
////*************************************************
//// MARK: - Resources (Wrapper to R.swift)
////*************************************************
//
//typealias Strings = R.string.localizable
//typealias Images = R.image
//typealias Nibs = R.nib
//typealias Files = R.file
//
////*************************************************
//// MARK: - Result<T>
////*************************************************
//
//typealias RxResult<T> = Result<T, Error>
