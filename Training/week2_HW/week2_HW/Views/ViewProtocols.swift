//
//  ViewProtocols.swift
//  week2_HW
//
//  Created by Consultant on 09/01/1401 AP.
//
import Foundation

protocol ViewControllerProtocol: AnyObject{
    func populatePosts()
    func displayDetailScreen(post: Post)
}
