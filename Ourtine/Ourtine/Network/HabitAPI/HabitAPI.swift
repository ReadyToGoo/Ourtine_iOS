//
//  Ourtine MOYA.swift
//  MoyaPractice
//
//  Created by 박민서 on 2023/08/06.
//

import Foundation
import Moya


enum HabitAPI {
    
    /// 습관 개설하기 POST
    /// - RequestBody:
    ///     - file : string($binary) : 이미지 파일
    ///     - habitCreatePostRequestDto : object : 습관 개설 내용 - HabitCreateFlowManager
    ///     - 이미지 파일은 Data 형식으로 변환해서 넣어주셔야 합니다.
    ///     - ex) if let jpegData = image.jpegData(compressionQuality: 0.8)
    // MARK: - 서버에게 확실히 물어보기 이미지 형식
    case postCreateHabit(imageData: Data, content: habitCreationContent)
    
    /// 습관 프로필 GET
    /// - PATH Parameters:
    ///     - habit_id : int : 습관 id
    case getHabitProfile(habitId: Int)
    
    /// 습관 참여 POST
    /// - PATH Parameters:
    ///     - habit_id : int : 습관 id
    case postParticipateHabit(habitId: Int)
    
    /// 습관 참여 취소 DELETE
    /// - PATH Parameters:
    ///     - habit_id : int : 습관 id
    case deleteCancelHabit(habitId: Int)
    
    /// 습관 프로필 사진 변경 PATCH
    /// - RequestBody:
    ///     - file : string($binary) : 이미지 파일
    ///     - 이미지 파일은 Data 형식으로 변환해서 넣어주셔야 합니다.
    ///     - ex) if let jpegData = image.jpegData(compressionQuality: 0.8)
    case patchHabitProfileImage(habitId: Int, imageData: Data)
        
    /// 습관 삭제 DELETE
    /// - PATH Parameters:
    ///     - habit_id : int : 습관 id
    case deleteHabit(habitId: Int)
    
    /// 습관 프로필의 위클리 로그 GET
    /// - PATH Parameters:
    ///     - habit_id : int : 습관 id
    case getSingleHabitWeeklyLog(habitId: Int)
    
    /// 카테고리별 습관 추천 목록 GET
    /// - Query Parameters:
    ///     - category : string : 습관 카테고리 - Available values : CAREER, EXERCISE, HOBBY, LANGUAGE, LIFESTYLE, MONEY, READING, STUDY
    case getDiscoverHabit(category: String)
    
    /// 나를 팔로우한 유저의 습관 목록 조회 GET
    /// - PATH Parameters:
    ///     - user_id : int : 나를 팔로우한 유저 id
    case getFollowedUserHabit(user_id: Int)
    
    /// 내가 팔로우한 유저의 습관 목록 조회 GET
    /// - PATH Parameters:
    ///     - user_id : int : 내가 팔로우한 유저 id
    case getFollowingUserHabit(user_id: Int)
    
    /// 유저들에게 습관 초대장 보내기 POST
    /// - RequestBody :
    ///     - JSON : { "friends" : [Int], "habitId" : Int }
    case postHabitInvitation(target: invitationTarget)
    
    /// 오늘 진행할 유저의 습관 GET
    case getTodaysHabit
    
    /// 마이페이지 습관 기록 GET
    case getMyPageWeeklyLogs
    
    /// 참여 습관 추천 목록 GET
    case getRecommendedHabit
    
    /// 습관 검색 GET
    /// - Query Parameters:
    ///     - sort_by : 정렬 순서입니다. - Available values : CREATED_DATE, RECRUITING, START_DATE<br>
    ///     - keyword : 검색 단어입니다.
    case getSearchHabit(sort_by: String, keyword: String)
    
}


///1️⃣ baseURL : 서버의 base URL / Moya는 이를 통하여 endpoint객체 생성
///2️⃣ path : 서버의 base URL 뒤에 추가 될 Path (일반적으로 API)
///3️⃣ method : HTTP Method (ex. .get / .post / .delete 등등)
///4️⃣ sampleData : 테스트용 Mock Data (테스트를 위한 목업 데이터를 제공할 때 사용)
///5️⃣ task : 리퀘스트에 사용되는 파라미터 설정
///6️⃣ validationType : 허용할 response의 타입
///7️⃣ headers : HTTP headers
extension HabitAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.hyobn.shop/habits")!
        //test 끝나면 뒤에 test 지우기
    }
    
    var path: String {
        switch self {
            
            // 습관 개설하기 POST
        case .postCreateHabit:
            return ""
            
            // 습관 프로필 GET / 습관 참여 POST / 습관 참여 취소 DELETE
        case .getHabitProfile(let habitId), .postParticipateHabit(let habitId), .deleteCancelHabit(let habitId), .patchHabitProfileImage(let habitId, _):
            return "/\(habitId)"
            
            // 습관 삭제 DELETE
        case .deleteHabit(let habitId):
            return "/\(habitId)/delete"
            
            // 습관 프로필의 위클리 로그 GET
        case .getSingleHabitWeeklyLog(let habitId):
            return "/\(habitId)/weekly-log"
            
            // 카테고리별 습관 추천 목록 GET
        case .getDiscoverHabit:
            return "/discover"
            
            // 나를 팔로우한 유저의 습관 목록 조회 GET
        case .getFollowedUserHabit(let user_id):
            return "/followed/users/\(user_id)"
            
            // 내가 팔로우한 유저의 습관 목록 조회 GET
        case .getFollowingUserHabit(let user_id):
            return "/following/users/\(user_id)"
            
            // 유저들에게 습관 초대장 보내기 POST
        case .postHabitInvitation:
            return "/invite"
            
            // 오늘 유저의 습관 GET
        case .getTodaysHabit:
            return "/me"
            
            // 마이페이지 습관 기록 GET
        case .getMyPageWeeklyLogs:
            return "/me/weekly-log"
            
            /// 참여 습관 추천 목록 GET
        case .getRecommendedHabit:
            return "/recommend"
            
            /// 습관 검색 GET
        case .getSearchHabit:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getHabitProfile, .getSingleHabitWeeklyLog, .getDiscoverHabit, .getFollowedUserHabit, .getFollowingUserHabit, .getTodaysHabit, .getMyPageWeeklyLogs, .getRecommendedHabit, .getSearchHabit:
            return .get
            
        case .postCreateHabit,.postParticipateHabit, .postHabitInvitation :
            return .post
            
        case .deleteCancelHabit, .deleteHabit :
            return .delete
            
        case .patchHabitProfileImage :
            return .patch
            
        }
    }
    
    /**
     .requestPlain:
     요청 본문을 가지지 않는 단순한 GET 요청 등에 사용됩니다.
     .requestData(Data):
     직접적인 데이터를 요청 본문으로 전송합니다. 예를 들어, 이미지나 바이너리 데이터를 전송할 때 사용할 수 있습니다.
     .requestJSONEncodable(Encodable):
     JSON 데이터를 인코딩하여 요청 본문으로 전송합니다. Encodable 프로토콜을 따르는 데이터 모델을 전송할 때 유용합니다.
     .requestJSONData(Data):
     미리 인코딩된 JSON 데이터를 요청 본문으로 전송합니다. 이미 JSON 데이터로 인코딩되어 있는 경우 사용할 수 있습니다.
     .requestParameters(parameters: [String: Any], encoding: ParameterEncoding):
     URL 쿼리 파라미터(query parameter) 형식으로 매개변수를 요청에 추가합니다. GET 요청에서 주로 사용됩니다.
     .uploadMultipart([MultipartFormData]):
     멀티파트 폼 데이터를 요청 본문으로 전송합니다. 파일 업로드와 함께 폼 데이터를 전송할 때 사용됩니다.
     .uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any]):
     멀티파트 폼 데이터를 요청 본문으로 전송하면서 동시에 URL 쿼리 파라미터를 전송할 때 사용됩니다.
     .downloadDestination(DownloadDestination):
     파일 다운로드 요청에서 사용되며, 파일의 저장 경로와 파일명을 지정할 수 있습니다.
     */
    var task: Moya.Task {
        switch self {
            
            // 습관 개설 태스크    이미지 Data와, 습관 내용 구조체를 가져옵니다.
        case .postCreateHabit(let imageData, let content) :
            
            // 이미지 data를 멀티파트폼 데이터로 지정
            let image_formData = MultipartFormData(provider: .data(imageData), name: "image", fileName: "test.png", mimeType: "image/png")
            
            // 습관 내용 구조체(habitCreationContent)를 JSON 인코딩
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(content)

                let json_formData = MultipartFormData(provider: .data(jsonData), name: "habitCreatePostRequestDto")
                
                let formData: [MultipartFormData] = [
                    image_formData,
                    json_formData
                ]
                
                print(formData)
                return .uploadMultipart(formData)
                
            } // 안되는 경우 에러처리
            catch let error {
                print("Error: \(error)")
                return .requestPlain
            }
        
            
            /// User 프로필 이미지 변경 케이스와 같이 변경하기
        case .patchHabitProfileImage(_, let imageData) :
            // 이미지 데이터를 Base64로 인코딩
            let base64ImageString = imageData.base64EncodedString()
            
            return .requestData(Data(base64ImageString.utf8))
            
            
        case .getDiscoverHabit(let category) :
            let params = [
                "category" : category
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
            
        case .postHabitInvitation(let target) :
            return .requestJSONEncodable(target)
            
            
        case .getSearchHabit(let sort_by, let keyword) :
            let params = [
                "sort_by" : sort_by,
                "keyword" : keyword
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
            
        default:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
//        switch self {
//        case .postCreateHabit:
//            return ["Content-Type" : "multipart/form-data"]
//        default :
//            return .none
//        }\
        return .none
    }
}



