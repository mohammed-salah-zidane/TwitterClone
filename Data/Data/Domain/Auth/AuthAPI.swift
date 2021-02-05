//
//  AuthAPI.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//
import Moya

enum AuthAPI
{
    case requestVerficationCode(mobile: String)
    case verifyCode(request: VarifyRequest)
    case personalInfo(request: PersonalInfoRequest)
    case vehicleInfo(request: VehicleInfoRequest)
    case colorsList
    case brandsList
    case brandModelsList(modelId: Int)
    case car(id: Int)
    case updateCar(id: Int, car: VehicleInfoRequest)
}

extension AuthAPI: TargetType
{
    var baseURL: URL
    {
        return Environments.shared.baseURL
    }
    
    var path: String
    {
        switch self
        {
        case .requestVerficationCode:
            return "auth/send-verification-code"
        case .verifyCode:
            return "auth/sign-in"
        case .personalInfo:
            return "captians/create"
        case .colorsList:
            return "cars/colors/list"
        case .brandsList:
            return "cars/brands"
        case .brandModelsList(let id):
            return "cars/brands/\(id)/models"
        case .vehicleInfo:
            return "captians/add-car"
        case .car(let id):
            return "captians/car/\(id)"
        case .updateCar(let id , _):
            return "captians/update-car/\(id)"
        }
    }
    
    var method: Moya.Method
    {
        switch self
        {
        case .requestVerficationCode, .verifyCode, .personalInfo, .vehicleInfo:
            return .post
        case .colorsList, .brandsList, .brandModelsList,.car:
            return .get
        case .updateCar:
            return .put
        }
    }
    
    var sampleData: Data
    {
        switch self
        {
        default:
            return Data()
        }
    }
    
    var headers: [String : String]?
    {
        let token = UserTokenManager.userToken ?? ""
        switch self {
        
        case .requestVerficationCode,.verifyCode:
            return ["Content-type": "application/json"]
            
        default:
            return ["Content-type": "application/json","Authorization":"Bearer " + token]
        }
    }
    
    var task: Task
    {
        switch self
        {
        case .requestVerficationCode(let mobile):
            return .requestParameters(parameters: ["mobile": mobile], encoding: JSONEncoding.default)
        case .verifyCode(let request):
            return .requestJSONEncodable(request)
        case .personalInfo(let request):
            let imageData = request.drivingLicense
            let nameData = request.name.data(using: String.Encoding.utf8) ?? Data()
            let dateOfBirthData = request.dateOfBirth.data(using: String.Encoding.utf8) ?? Data()
            let identityNumberData = request.identitiyNumber.data(using: String.Encoding.utf8) ?? Data()
            let licenceNumberData = request.licenceNumber.data(using: String.Encoding.utf8) ?? Data()
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "captian-license", fileName: "\((UUID().uuidString)) thumbnail.jpeg", mimeType: "image/jpeg")]
            formData.append(Moya.MultipartFormData(provider: .data(nameData), name: "name"))
            formData.append(Moya.MultipartFormData(provider: .data(dateOfBirthData), name: "dateOfBirth"))
            formData.append(Moya.MultipartFormData(provider: .data(identityNumberData), name: "identitiyNumber"))
            formData.append(Moya.MultipartFormData(provider: .data(licenceNumberData), name: "licenceNumber"))
            return .uploadMultipart(formData)
            
        case .vehicleInfo(let request), .updateCar(_, let request):
            let carPhotoImage = request.carPhoto
            let carLicenseImage = request.carLicense
            let manufacturingYear = request.manufacturingYear.data(using: String.Encoding.utf8) ?? Data()
            let plateNumbers = request.plateNumbers.data(using: String.Encoding.utf8) ?? Data()
            let plateCharacters = request.plateCharacters.data(using: String.Encoding.utf8) ?? Data()
            let colorId = request.colorId.data(using: String.Encoding.utf8) ?? Data()
            let modelId = request.modelId.data(using: String.Encoding.utf8) ?? Data()
            let brandId = request.brandId.data(using: String.Encoding.utf8) ?? Data()
            let totalSeats = request.totalSeats.data(using: String.Encoding.utf8) ?? Data()
            
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(carLicenseImage), name: "license", fileName: "\((UUID().uuidString)) thumbnail.jpeg", mimeType: "image/jpeg")]
            formData.append(Moya.MultipartFormData(provider: .data(carPhotoImage), name: "photo", fileName: "\((UUID().uuidString)) thumbnail.jpeg", mimeType: "image/jpeg"))
            formData.append(Moya.MultipartFormData(provider: .data(manufacturingYear), name: "manufacturingYear"))
            formData.append(Moya.MultipartFormData(provider: .data(plateNumbers), name: "plateNumbers"))
            formData.append(Moya.MultipartFormData(provider: .data(plateCharacters), name: "plateCharacters"))
            formData.append(Moya.MultipartFormData(provider: .data(colorId), name: "colorId"))
            formData.append(Moya.MultipartFormData(provider: .data(modelId), name: "modelId"))
            formData.append(Moya.MultipartFormData(provider: .data(brandId), name: "brandId"))
            formData.append(Moya.MultipartFormData(provider: .data(totalSeats), name: "totalSeats"))
            return .uploadMultipart(formData)
        default:
            return .requestPlain
        }
    }
}
