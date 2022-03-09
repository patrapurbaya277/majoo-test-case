import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/extra/custom_shimmer.dart';

import '../login/login_page.dart';

class HomeLoaded extends StatelessWidget {
  final List<Movie> data;

  const HomeLoaded({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return movieItemWidget(data[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget movieItemWidget(Movie movie) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            // child: Image.network(
            //   movie.posterPath.toString(),
            // ),
            child: CachedNetworkImage(
              imageUrl: movie.posterPath.toString(),
              placeholder: (context, url) => MovieListShimmer(
                child: Container(
                  height: 200,
                  // width: double.infinity,
                  color: Colors.black,
                ),
              ),
              memCacheHeight: 200,
              memCacheWidth: 135,
              height: 200,
              width: 135,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(movie.title.toString()),
          )
        ],
      ),
    );
  }
}
