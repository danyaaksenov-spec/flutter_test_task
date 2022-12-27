import '../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getPosts();

  Future<void> addPosts(List<PostModel> posts);

  Future<void> clearBox();

  Future<bool> checkBox();
}
