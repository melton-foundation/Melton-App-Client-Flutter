import 'package:melton_app/api/api.dart';

import 'package:melton_app/models/PostModel.dart';
import 'package:melton_app/models/ProfileModel.dart';

import '../constants/test_constants.dart';

class MockApiService extends ApiService {
  @override
  Future<List<PostModel>> getPostPreviewList(bool sendTopThree) async {
    PostModel postModel = PostModel(
        id: 1,
        title: "title",
        description: "desc",
        content: null,
        previewImage: null,
        created: DateTime.now(),
        tags: [],
        lastUpdated: null);
    return Future.value([postModel]);
  }

  @override
  Future<ProfileModel> getProfile() async {
    return ProfileModel(
      email: TestConstants.PROFILE_FELLOW_EMAIL,
      name: TestConstants.PROFILE_FELLOW_NAME,
      isJuniorFellow: TestConstants.PROFILE_IS_JF,
      points: TestConstants.PROFILE_FELLOW_IMPACT_POINTS,
      campus: TestConstants.PROFILE_FELLOW_CAMPUS,
      city: TestConstants.PROFILE_FELLOW_CITY,
      batch: TestConstants.PROFILE_FELLOW_BATCH,
      bio: TestConstants.PROFILE_FELLOW_BIO,
      work: TestConstants.PROFILE_FELLOW_WORK,
      phoneNumber: PhoneNumber(countryCode: "+91", phoneNumber: "1111111111"),
      socialMediaAccounts: SocialMediaAccounts(
          facebook: "",
          instagram: "",
          twitter: "",
          wechat: "",
          linkedin: "",
          others: [""]),
      SDGs: SDGList.fromJson([1, 2, 3]),
      picture: null,
    );
  }
}
