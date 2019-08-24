String userLogin = """
mutation userLogin(\$username: String!, \$password: String!) {
  result: userLogin(username: \$username, password: \$password) {
    __typename
    status
    message
    token
    userInfo {
      _id
      nickname
      avatarUrl
    }
  }
}
""";

String userInfo = """
query userInfo {
  userInfo: userInfo {
      __typename
      _id
      nickname
      avatarUrl
  }
}
""";

String getPhoneNumberCode = """
mutation getPhoneNumberCode(\$purePhoneNumber: String!, \$countryCode: String!) {
  result: getPhoneNumberCode(purePhoneNumber: \$purePhoneNumber, countryCode: \$countryCode) {
    __typename
    status
    message
  }
}
""";

String userRegister = """
mutation userRegister(\$input: UserRegisterInput) {
  result: userRegister(input: \$input) {
    __typename
    status
    message
    token
    userInfo {
      _id
      nickname
      avatarUrl
    }
  }
}
""";

String userLoginByPhonenumberCode = """
mutation userLoginByPhonenumberCode(\$purePhoneNumber: String!, \$countryCode: String!, \$code: String!) {
  result: userLoginByPhonenumberCode(purePhoneNumber: \$purePhoneNumber, countryCode: \$countryCode, code: \$code) {
    __typename
    status
    message
    token
    userInfo {
      _id
      nickname
      avatarUrl
    }
  }
}
""";
