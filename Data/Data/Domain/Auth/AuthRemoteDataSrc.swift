//
//  AuthRemoteDataSrc.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//
import Moya
import RxSwift

public class AuthRemoteDataSrc {
    
    let api: MoyaProvider<AuthAPI>
    
    init(api: MoyaProvider<AuthAPI>) {
        self.api = api
    }
    
    func requestVerficationCode(mobile: String) -> Single<SuccessResponse> {
        api.rx.request(.requestVerficationCode(mobile: mobile)).mapItem()
    }
    
    func varifyCode(request: VarifyRequest) -> Single<BaseResponse<VerifyCodeResponse>> {
        api.rx.request(.verifyCode(request: request)).mapItem()
    }
    
    func sendPersonalInfo(request: PersonalInfoRequest) -> Single<BaseResponse<Captain>> {
        api.rx.request(.personalInfo(request: request)).mapItem()
    }
    
    func getColorsList() -> Single<BaseResponse<[SimpleItem]>> {
        api.rx.request(.colorsList).mapItem()
    }
    
    func getBrandsList() -> Single<BaseResponse<[SimpleItem]>> {
        api.rx.request(.brandsList).mapItem()
    }
    
    func getBrandModelsList(brandId: Int) -> Single<BaseResponse<[SimpleItem]>> {
        api.rx.request(.brandModelsList(modelId: brandId)).mapItem()
    }
    
    func sendVehicleInfo(request: VehicleInfoRequest) -> Single<SuccessResponse> {
        api.rx.request(.vehicleInfo(request: request)).mapItem()
    }
    
    func getCar(id: Int) -> Single<BaseResponse<Car>> {
        api.rx.request(.car(id: id)).mapItem()
    }
    
    func updateCar(id: Int, request: VehicleInfoRequest) -> Single<SuccessResponse> {
        api.rx.request(.updateCar(id: id, car: request)).mapItem()
    }
}
