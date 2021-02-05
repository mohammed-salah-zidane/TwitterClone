//
//  AuthRepo.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//
import Moya
import RxSwift
import RxCocoa

public class AuthRepo {
    
    public let remoteDataSrc: AuthRemoteDataSrc
    
    public static func create() -> AuthRepo {
        let authAPI: MoyaProvider<AuthAPI> = MoyaProviderBuilder.makeProvider()
        let authRemoteDataSrc = AuthRemoteDataSrc(api: authAPI)
        return AuthRepo(remote: authRemoteDataSrc)
    }
    
    public init(remote: AuthRemoteDataSrc) {
        self.remoteDataSrc = remote
    }
    
    public func requestVerficationCode(mobile: String) -> Single<Result<Bool,NetworkError>> {
        remoteDataSrc.requestVerficationCode(mobile: mobile).map { response in
            guard response.done else {
                return .failure(.errorMessage(text: response.error?.joined(separator: "\n") ?? ""))
            }
            return .success(true)
        }
    }
    
    public func varifyCode(request: VarifyRequest) -> Single<Result<VerifyCodeResponse,NetworkError>> {
        remoteDataSrc.varifyCode(request: request).map { response in
            guard let userData = response.data , response.done else {
                return .failure(.errorMessage(text: response.error?.joined(separator: "\n") ?? ""))
            }
            return .success(userData)
        }
    }
    
    public func sendPersonalInfo(request: PersonalInfoRequest) -> Single<Result<Captain,NetworkError>> {
        remoteDataSrc.sendPersonalInfo(request: request).map { response in
            guard let captainData = response.data, response.done else {
                return .failure(.errorMessage(text: response.error?.joined(separator: "\n") ?? ""))
            }
            return .success(captainData)
        }
    }
    
    public func sendVehicleInfo(request: VehicleInfoRequest) -> Single<Result<Bool,NetworkError>> {
        remoteDataSrc.sendVehicleInfo(request: request).map { response in
            guard response.done else {
                return .failure(.errorMessage(text: response.error?.joined(separator: "\n") ?? ""))
            }
            return .success(response.done)
        }
    }
    
    public func getColorList() -> Single<[SimpleItem]?> {
        remoteDataSrc.getColorsList().map { response in
            return response.data
        }
    }
    
    public func getBrandsList() -> Single<[SimpleItem]?> {
        remoteDataSrc.getBrandsList().map { response in
            return response.data
        }
    }
    
    public func getBrandModelsList(brandId: Int) -> Single<[SimpleItem]?> {
        remoteDataSrc.getBrandModelsList(brandId: brandId).map { response in
            return response.data
        }
    }

    public func getCar(carId: Int) -> Single<Car?> {
        remoteDataSrc.getCar(id: carId).map { response in
            return response.data
        }
    }
    
    public func updateCar(id: Int, request: VehicleInfoRequest) -> Single<Result<Bool,NetworkError>> {
        remoteDataSrc.updateCar(id: id, request: request).map { response in
            guard response.done else {
                return .failure(.errorMessage(text: response.error?.joined(separator: "\n") ?? ""))
            }
            return .success(response.done)
        }
    }
}
