part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class LoadPostEvent extends PostEvent {}

class RefreshPostsEvent extends PostEvent {}
