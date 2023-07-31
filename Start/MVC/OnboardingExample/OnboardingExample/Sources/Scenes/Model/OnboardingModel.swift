//
//  OnboardingModel.swift
//  OnboardingExample
//
//  Created by Vladimir Fibe on 31.07.2023.
//

import Foundation

struct Onboarding {
    let index: Int
    let title: String
    let description: String
    let imageName: String
}

final class OnboardingModel {
    func createModels() -> [Onboarding] {
        [
            .init(index: 0,
                  title: "Изучай материалы и выполняй задания",
                  description: "Обучения iOS разработке требует много практики, для этого нужно внимательно изучать материалы и выполнять все задания из них. Не забывай повторять примеры, которые показаны в конспектах, так ты быстрее привыкнешь писать код. И да, у нас есть домашние задания, их выполнения и обратная связь по ним очень важны",
                  imageName: "code")
        ]
    }
}
