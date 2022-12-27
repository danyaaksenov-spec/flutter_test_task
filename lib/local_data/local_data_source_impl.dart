import 'package:hive/hive.dart';
import 'package:test_app/local_data/local_data_source.dart';
import 'package:test_app/models/post_model.dart';

class LocalDataSourceImpl extends LocalDataSource {
  late Box _box;
  String boxName = 'posts';

  LocalDataSourceImpl() {
    Hive.openBox<PostModel>(boxName).then((value) => _box = value);
  }

  @override
  Future<List<PostModel>> getPosts() async {
    return _box.values.toList().cast<PostModel>();
  }

  @override
  Future<void> addPosts(List<PostModel> posts) async {
    await _box.addAll(posts);
  }

  @override
  Future<void> clearBox() async {
    return _box.deleteAll(_box.keys);
  }

  @override
  Future<bool> checkBox() {
    return Hive.boxExists(boxName);
  }
}
