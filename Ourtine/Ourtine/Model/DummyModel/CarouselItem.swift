//
//  CarouselItem.swift
//  Ourtine
//
//  Created by eunji on 2023/07/28.
//
import UIKit

struct CarouselItem {
    let image: UIImage?
    let title: String
}

private var items: [CarouselItem] = [
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card1"),
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card2"),
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card3"),
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card4"),
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card5"),
    CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card6")
]
