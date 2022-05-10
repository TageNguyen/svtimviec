// this class contains all api urls
class ApiUrl {
  static const domain = 'http://svtimviec.rossleestdio.com/api';
  static const localHost = 'http://localhost:8888/svtimviec/public/api';

  // auth
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const verifyEmail = '/auth/confirm-email';
  static const getCurrentUserInformations = '/user/info';

  // user
  static const updateRequiredInformations = '/user/update-requirement-infos';

  // recruitment post
  static const getRecruitmentPosts = '/recruitment-news';
  static const getRecruitmentPostDetail = '/recruitment-news/detail';
  static const applyForRecruitmentPost = '/recruitment-news/apply';
  static const reportRecruitmentPost = '/recruitment-news/report';
  static const saveRecruitmentPosts = '/recruitment-news/add-favorite';
  static const getSavedRecruitmentPosts = '/recruitment-news/favorite-news';
  static const unSaveRecruitmentPosts = '/recruitment-news/delete-favorite';
}
