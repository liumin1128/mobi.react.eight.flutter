String commentListSchema = """
  query CommentList(\$first: Int, \$skip: Int, \$session: String!) {
    list: comments(first: \$first, skip: \$skip, session: \$session) {
      __typename
      _id
      session
      content
      replyCount
      zanCount
      zanStatus
      createdAt
      user {
        _id
        nickname
        avatarUrl
      }
      replys(first: 2) {
        __typename
        _id
        content
        zanCount
        zanStatus
        createdAt
        user {
          _id
          nickname
          avatarUrl
        }
        replyTo {
          _id
          user {
            _id
            nickname
            avatarUrl
          }
        }
      }
    }
    meta: _commentsMeta(session: \$session) {
      count
      commentCount
    }
  }
""";

String replyListSchema = """
query ReplyList(\$first: Int, \$skip: Int, \$commentTo: String!) {
  list: replys(first: \$first, skip: \$skip, commentTo: \$commentTo) {
    __typename
    _id
    content
    zanCount
    zanStatus
    createdAt
    user {
      _id
      nickname
      avatarUrl
    }
    replyTo {
      _id
      user {
        _id
        nickname
        avatarUrl
      }
    }
  }
}
""";

String createCommentSchema = """
  mutation createComment(\$content: String!, \$session: String!, \$replyTo: String, \$commentTo: String) {
    result: createComment(content: \$content, session: \$session, replyTo: \$replyTo, commentTo: \$commentTo) {
      status
      message
      data {
        __typename
        _id
        createdAt
        content
        session
        replyCount
        zanCount
        zanStatus
        replys {
          __typename
        }
        user {
          _id
          nickname
          avatarUrl
        }
      }
    }
  }
""";

String createReplySchema = """
  mutation createComment(\$content: String!, \$session: String!, \$replyTo: String, \$commentTo: String) {
    result: createComment(content: \$content, session: \$session, replyTo: \$replyTo, commentTo: \$commentTo) {
      status
      message
      data {
        __typename
        _id
        content
        zanCount
        zanStatus
        createdAt
        user {
          _id
          nickname
          avatarUrl
        }
        replyTo {
          _id
          user {
            _id
            nickname
            avatarUrl
          }
        }
      }
    }
  }
""";

String deleteCemmentScheme = """
  mutation deleteComment(\$_id: String!) {
    result: deleteComment(_id: \$_id) {
      status
      message
    }
  }
""";
