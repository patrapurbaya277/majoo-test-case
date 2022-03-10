import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/ui/extra/detail_page.dart';
import '../../common/widget/custom_shimmer.dart';

class HomeLoaded extends StatelessWidget {
  final List<List<Movie>> data;

  const HomeLoaded({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildSlider() {
      return Container(
        // height: 400,
        color: Colors.black.withOpacity(0.1),
        child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1,
              enlargeCenterPage: true,
            ),
            items: data[2]
                .map(
                  (e) => InkWell(
                    onTap: () {
                      // print(e.id);
                      // print(e.type);
                      // print(e.posterPath);
                      // print(e.title);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailPage(id: e.id.toString(), type: e.type!)));
                    },
                    child: Stack(
                      children: [
                        Container(
                          foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          )),
                          child: CachedNetworkImage(
                            imageUrl: e.posterPath.toString(),
                            placeholder: (context, url) => CustomShimmer(
                              child: Container(
                                height: 500,
                                // width: double.infinity,
                                color: Colors.black,
                              ),
                            ),
                            memCacheHeight: 900,
                            memCacheWidth: 600,
                            height: 600,
                            width: 405,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Trending Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                e.title.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList()),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          _buildSlider(),
          SizedBox(
            height: 25,
          ),
          _buildMovies("Now Playing Movies", data[0], context),
          _buildMovies("Popular Movies", data[1], context),
          TextButton(
            onPressed: () {
              context.read<AuthBlocCubit>().logOut();
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget _buildMovies(String label, List<Movie> data, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 15),
              ...data.map((e) => movieItemWidget(e, context)).toList(),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget movieItemWidget(Movie movie, context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DetailPage(
                  id: movie.id.toString(),
                  type: movie.type!,
                )));
      },
      child: Container(
        width: 135,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath.toString(),
                placeholder: (context, url) => CustomShimmer(
                  child: Container(
                    height: 200,
                    // width: double.infinity,
                    color: Colors.black,
                  ),
                ),
                memCacheHeight: 400,
                memCacheWidth: 270,
                height: 200,
                width: 135,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                movie.title.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
