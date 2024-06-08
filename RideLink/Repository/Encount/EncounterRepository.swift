//
//  EncounterRepository.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/25.
//

import Foundation
import Combine
import Alamofire

    let apiClient = APIClient.shared

    func sendFriendReqest(toUid: String) -> AnyPublisher<Bool, Error> {
        let subject = CurrentValueSubject<Bool, Error>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    func receptionFriendReqest() -> AnyPublisher<FriendInfoModel, Error> {
        let subject = CurrentValueSubject<FriendInfoModel, Error>(FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil)))
        subject.send((FriendInfoModel(id: "11", isOnline: true, profile: UserProfileModel(userName: "a", bikeName: "a", profileIcon: "x", touringcomment: nil))))
        return subject.eraseToAnyPublisher()
    }

    func getEncountInfo() -> AnyPublisher<[EncountInfoModel], Error> {
        return Deferred {
            Future { promise in
                self.apiClient.fetchData(endPoint: paths.encount.rawValue, params: nil, type: EncountResponse.self)
                    .receive(on: DispatchQueue.global(qos: .background))
                    .sink { response in
                        switch response {
                        case.failure(let error):
                            promise(.failure(error))
                        case .finished:
                            return
                        }
                    } receiveValue: { result in
                        promise(.success(result.encountInfos))
                    }

            }
        }
        .eraseToAnyPublisher()
    }

