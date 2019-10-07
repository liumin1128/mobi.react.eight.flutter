String dynamicListSchema = """
query DynamicList(\$first: Int, \$skip: Int, \$topic: String, \$user: String) {
  list: dynamics(first: \$first, skip: \$skip, topic: \$topic, user: \$user) {
    __typename
    createdAt
    _id
    content
    pictures
    zanCount
    zanStatus
    commentCount
    topics {
      _id
      title
      number
    }
    user {
      _id
      nickname
      avatarUrl
      sign
    }
  }
  meta: _dynamicsMeta {
    count
  }
}
""";

String dynamicDetailSchema = """
query DynamicDetail(\$_id: String!) {
  data: dynamic(_id: \$_id) {
    __typename
    _id
    content
    pictures
    iframe
    createdAt
    zanCount
    zanStatus
    commentCount
    topics {
      _id
      title
      number
    }
    user {
      _id
      nickname
      avatarUrl
      sign
    }
  }
}
""";

String dynamicCreateSchema = """
mutation DynamicCreate(\$input: DynamicInput) {
  result: DynamicCreate(input: \$input) {
    status
    message
    data {
      __typename
      _id
      content
      pictures
      iframe
      zanCount
      zanStatus
      commentCount
      topics {
        _id
        title
        number
      }
      createdAt
      user {
        _id
        nickname
        avatarUrl
        sign
      }
    }
  }
}
""";
