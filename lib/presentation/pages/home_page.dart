import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hive_bloc/hive_bloc.dart';
import '../bloc/photo_bloc/photo_bloc.dart';
import '../widgets/shimmer_widget.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo App')),
      body: RefreshIndicator(
        onRefresh: () async{
context.read<PhotoBloc>().add(FetchPhotos());
        },
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoLoading) {
              return const ShimmerWidget();}
             else if (state is PhotoLoaded) {
              return BlocBuilder<HiveStorageBloc,HiveStorageState>(builder: (ctx,hiveState){
                return ListView.builder(
                  itemCount: state.photos.length,
                  itemBuilder: (context, index) {
                    final photo = state.photos[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ListTile(
                        title: Text(photo.title),
                        leading: Image.network(photo.thumbnailUrl),
                        trailing: IconButton(onPressed: (){
                          context.read<HiveStorageBloc>().add(AddDataToHiveListEvent(photoData: state.photos[index]));
                        }, icon: hiveState.photosList.contains(state.photos[index]) ?const Icon(Icons.favorite):const Icon(Icons.favorite_outline_rounded)),
                      ),
                    );
                  },
                );
              });
            } else if (state is PhotoError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}