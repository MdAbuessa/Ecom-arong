import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/features/user/social/model/club_model.dart';

final List<Post> dummyPosts = [
  Post(
    slug: '1',
    postCreator: PostCreator(
      name: '🍀🍀Lucky🌸🌸',
      avatar: 'assets/images/user_img.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'My step covered thus far today.\nThank God for His grace to cover this amount of steps!!!\nBlessed Fri/Sat, all my Pacer pals!!!\nGloria a Dios!!!',
    images: ['assets/images/post1.png'],
    likesCount: 116,
    commentsCount: 38,
  ),
  Post(
    slug: '2',
    postCreator: PostCreator(
      name: '🍀🍀Lucky🌸🌸',
      avatar: 'assets/images/person2.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'My step covered thus far today.\nThank God for His grace to cover this amount of steps!!!\nBlessed Fri/Sat, all my Pacer pals!!!\nGloria a Dios!!!',
    images: [
      'assets/images/post2.png',
      'assets/images/post3.png',
      'assets/images/post4.png',
      'assets/images/post5.png',
    ],
    likesCount: 116,
    commentsCount: 38,
  ),
  Post(
    slug: '3',
    postCreator: PostCreator(
      name: '🍀🍀Lucky🌸🌸',
      avatar: 'assets/images/person3.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'My step covered thus far today.\nThank God for His grace to cover this amount of steps!!!\nBlessed Fri/Sat, all my Pacer pals!!!\nGloria a Dios!!!',
    images: ['assets/images/post6.png'],
    likesCount: 116,
    commentsCount: 38,
  ),
];

final List<Post> dummyFollowingPosts = [
  Post(
    slug: 'f1',
    postCreator: PostCreator(
      name: 'The Racing Club',
      avatar: 'assets/images/post4.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'New Challenge Available!\nThe club owner has published a new challenge.\nCheck out the link below to get started.',
    images: [],
    likesCount: 116,
    commentsCount: 38,
  ),
  Post(
    slug: 'f2',
    postCreator: PostCreator(
      name: 'The Racing Club',
      avatar: 'assets/images/post2.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'New Challenge Available!\nThe club owner has published a new challenge.\nCheck out the link below to get started.',
    images: [],
    likesCount: 116,
    commentsCount: 38,
  ),
  Post(
    slug: 'f3',
    postCreator: PostCreator(
      name: 'The Racing Club',
      avatar: 'assets/images/post5.png',
      isFollowing: true,
    ),
    createdAt: 'Posted 3m ago',
    caption:
        'New Challenge Available!\nThe club owner has published a new challenge.\nCheck out the link below to get started.',
    images: [],
    likesCount: 116,
    commentsCount: 38,
  ),
];

final List<ClubModel> dummyClubPosts = [
  ClubModel(
    id: 'c1',
    name: 'The Racing Club',
    avatar: 'assets/images/post4.png',
    subtitle: 'Walking Team Racing group',
    memberCount: 500,
    location: 'San Francisco -> USA',
    tags: ['Walking', 'Running', 'Fitness'],
  ),
  ClubModel(
    id: 'c2',
    name: 'The Racing Group',
    avatar: 'assets/images/post1.png',
    subtitle: 'Walking Team Racing group',
    memberCount: 500,
    location: 'San Francisco -> USA',
    tags: ['Walking', 'Running', 'Fitness'],
  ),
  ClubModel(
    id: 'c3',
    name: 'The Racing Group',
    avatar: 'assets/images/post5.png',
    subtitle: 'Walking Team Racing group',
    memberCount: 500,
    location: 'San Francisco -> USA',
    tags: ['Walking', 'Running', 'Fitness'],
  ),
];
