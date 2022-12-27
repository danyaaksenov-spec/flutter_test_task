import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/repository/repository.dart';

import '../models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DataRepository repository;
  PostBloc(this.repository) : super(PostInitState()) {
    on<LoadPostEvent>(_loadPosts);
    on<RefreshPostsEvent>(_refreshPosts);
  }

  _loadPosts(LoadPostEvent event, Emitter<PostState> emit) async {
    if(repository.checkBox() == true) {
      emit(PostLoadedState(posts: repository.getPostsFromLocal()));
    } else {
      emit(PostLoadingState());
      final List<PostModel> fetchedPosts =
      await repository.getPostsAndSaveToLocal();
      emit(PostLoadedState(posts: fetchedPosts));
    }
  }

  _refreshPosts(RefreshPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    final List<PostModel> posts =
    await repository.refreshPosts();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(PostLoadedState(posts: posts));
  }

}
