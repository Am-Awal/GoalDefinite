//
//  GoalMove.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct GoalMove {
    let id : UUID
    var description: String
    var executionStart: Date
    var executionEnd: Date
}

var goalMoves = [
    GoalMove(id: UUID(),description: "Leo duis ut diam quam nulla porttitor. Consectetur lorem donec massa sapien faucibus et. Id ornare arcu odio ut sem nulla pharetra diam.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Varius morbi enim nunc faucibus a pellentesque sit amet. Commodo quis imperdiet massa tincidunt nunc pulvinar sapien et ligula.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Vel facilisis volutpat est velit egestas dui. Enim blandit volutpat maecenas volutpat blandit.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Iaculis eu non diam phasellus vestibulum lorem sed.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Molestie a iaculis at erat pellentesque adipiscing commodo. Hac habitasse platea dictumst quisque sagittis. Nisl purus in mollis nunc.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Build an iOS app for iOS 15 with custom layouts...", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Ac placerat vestibulum lectus mauris ultrices eros in cursus. Urna molestie at elementum eu facilisis sed odio morbi.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Mi ipsum faucibus vitae aliquet nec ullamcorper. Ipsum a arcu cursus vitae congue. Placerat vestibulum lectus mauris ultrices eros in cursus turpis massa.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Pretium viverra suspendisse potenti nullam ac tortor. Tempus urna et pharetra pharetra massa.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Suspendisse faucibus interdum posuere lorem ipsum dolor. Habitant morbi tristique senectus et netus et malesuada fames.", executionStart: Date(), executionEnd: Date()),
    GoalMove(id: UUID(), description: "Convallis convallis tellus id interdum velit laoreet id donec. Nulla posuere sollicitudin aliquam ultrices.", executionStart: Date(), executionEnd: Date())
]
