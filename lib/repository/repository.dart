import '../local_data/local_data_source_impl.dart';
import '../remote_data/api_data_source.dart';

class DataRepository {
  late ApiDataSource _apiDataSource;
  late LocalDataSourceImpl _localDataSourceImpl;

  DataRepository() {
    _apiDataSource = ApiDataSource();
    _localDataSourceImpl = LocalDataSourceImpl();
  }

  getPostsAndSaveToLocal() async {
    var resp = await _apiDataSource.fetchPosts();
    _localDataSourceImpl.addPosts(resp);
    return _localDataSourceImpl.getPosts();
  }

  checkBox() async {
    return _localDataSourceImpl.checkBox();
  }

  getPostsFromLocal() async {
    return _localDataSourceImpl.getPosts();
  }

  refreshPosts() async {
    _localDataSourceImpl.clearBox();
    var resp = await _apiDataSource.fetchPosts();
    _localDataSourceImpl.addPosts(resp);
    return _localDataSourceImpl.getPosts();
  }
}
