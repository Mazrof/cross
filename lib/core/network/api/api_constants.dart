class ApiConstants {
  static String register = "auth/signup";

  static const login = 'auth/login';

  static const sendOtpMial = 'auth/send-code';
  static const sendOtpPhone = 'auth/send-code-sms';
  static const logout = 'auth/logout';

  // static const refreshToken = 'auth/refresh-token';
  static const verifyOtp = 'auth/verify-code';
  static const socialLogin = 'auth/social-login';

  static const GoogleSignIn = 'auth/google';
  static const GithubSignIn = 'auth/github';
  static const googleCallBack = 'auth/google/callback';
  static const githubCallBack = 'auth/github/callback';

  static const githubClientId = 'Ov23liNhZ8W3afDrCcjO';
  static const githubClientSecret = '14df323aed985c282ea8eeef2612579434dd3eb8';
  static const githubRedirectUrl =
      'https://telegram-clone-a4785.firebaseapp.com/__/auth/handler';

//  get  groups         groups/
//  post  creat group   groups/

// members         post     groups/:id/members/invitation     link invitation
// 		get      groups/:id/members        get group members
// 		post     groups/:id/members        add members
// 		patch    groups/:id/members/:id    update member role message  by admin only
// 		delete   groups/:id/members/:id

  static const getGroups = 'groups/';
  static const createGroup = 'groups/';
  static const linkInvitation = 'groups/:id/members/invitation';
  static const getGroupMembers = 'groups/:id/members';
  static const addMembers = 'groups/:id/members';
  static const updateMemberRole = 'groups/:id/members/:id';
  static const deleteMember = 'groups/:id/members/:id';

//settings
  static const profileSetting = 'profile/';
  static const blockedUsers = 'user/block';
  static const contacts = 'chats/my-chats';
  static const globalSearchQuery = "search";
}
