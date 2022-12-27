import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return context.read<PostBloc>().add(RefreshPostsEvent());
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PostLoadedState) {
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    height: MediaQuery.of(context).size.height / 5,
                    width: double.maxFinite,
                    child: ListTile(
                      title: Text(state.posts[index].title),
                      subtitle: Text(state.posts[index].body),
                    ),
                  ),
                ),
              );
            }
            if (state is PostNoDataState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
