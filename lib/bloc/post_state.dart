part of 'post_bloc.dart';

abstract class PostState {
  const PostState();
}

class PostInitState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;

  const PostLoadedState({
    required this.posts,
  });
}

class PostNoDataState extends PostState {
  final String message;

  const PostNoDataState(this.message);

  @override
  String toString() => 'No data (message : $message)';
}

