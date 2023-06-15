//
//  Message.swift
//  ElasticTest
//
//  Created by Sam Greenhill on 5/28/23.
//

import Foundation


// Message Model

struct Message: Identifiable {
    var id: UUID = .init()
    var image: String
    var name: String
    var message: String
    var online: Bool
    var read: Bool
}

let sampleMessages: [Message] = [
    .init(image: "Pic 1",
          name: "iJustine",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 2",
          name: "Miranda",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 3",
          name: "Jenna",
          message: "Hi, What's up? 3",
          online: true,
          read: false),
    .init(image: "Pic 4",
          name: "Emily",
          message: "How are you doing 4",
          online: false,
          read: false),
    .init(image: "Pic 5",
          name: "Pic 5--@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 6",
          name: "Pic 6--@",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 7",
          name: "Pic 7--@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 8",
          name: "Pic 8---@",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 9",
          name: "Pic 9---@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 10",
          name: "Pic 10--@",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 11",
          name: "Pic 11--@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 12",
          name: "Pic 12--@",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 13",
          name: "Pic 13--@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 14",
          name: "Pic 14--@",
          message: "How are you doing",
          online: false,
          read: false),
    .init(image: "Pic 15",
          name: "Pic 15--@",
          message: "Hi, What's up?",
          online: true,
          read: false),
    .init(image: "Pic 16",
          name: "Pic 16--@@",
          message: "How are you doing",
          online: false,
          read: false)



]
