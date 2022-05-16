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
  static const getRecruiterInformations = '/user/recruiter';
  static const getStudentInformations = '/user/student';
  static const updatePassword = '/user/update-password';
  static const updateUserInformations = '/user/update-info';

  // recruitment post
  static const getRecruitmentPosts = '/recruitment-news';
  static const getRecruitmentPostDetail = '/recruitment-news/detail';
  static const applyForRecruitmentPost = '/recruitment-news/apply';
  static const reportRecruitmentPost = '/recruitment-news/report';
  static const saveRecruitmentPosts = '/recruitment-news/add-favorite';
  static const getSavedRecruitmentPosts = '/recruitment-news/favorite-news';
  static const unSaveRecruitmentPosts = '/recruitment-news/delete-favorite';

  // recruiter api
  static const getPostsHistory = '/recruitment-news/history-news';
  static const getRecruitmentDetail = '/recruitment-news/detail-news';
  static const getListCandidates = '/recruitment-news/list-apply';
  static const getListJobCategories = '/get-all-category';
  static const createNewRecruitmentPost = '/recruitment-news/create';
  static const updateRecruitmentPost = '/recruitment-news/edit';
  static const deleteRecruitmentPost = '/recruitment-news/delete-news';
}
