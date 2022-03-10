import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:majootestcase/ui/extra/error_screen.dart';
import 'package:majootestcase/ui/extra/loading.dart';

import '../../bloc/detail_bloc/detail_bloc_cubit.dart';
import '../../common/widget/custom_shimmer.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String type;
  const DetailPage({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<DetailBlocCubit>().getDetail(widget.id, widget.type);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<DetailBlocCubit, DetailBlocState>(
        builder: (context, state) {
      if (state is DetailBlocErrorState) {
        return ErrorScreen(
          message: state.error,
          retry: () {
            context.read<DetailBlocCubit>().getDetail(widget.id, widget.type);
          },
        );
      }
      if (state is DetailBlocSuccessState) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("Movie Detail"),
          // ),
          floatingActionButton: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView(
              children: [
                _buildImage(state),
                SizedBox(height:10),
                _buildText(
                    "Popularity", state.data.popularity!.ceil().toString()),
                _buildText("Overview", state.data.overview!),
                
              ],
            ),
          ),
        );
      }
      return LoadingIndicator();
    });
  }

  Widget _buildImage(state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: 600,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.8),
                  Colors.transparent
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: state.data.posterPath.toString(),
              placeholder: (context, url) => CustomShimmer(
                child: Container(
                  height: 600,
                  color: Colors.black,
                  width: double.infinity,
                ),
              ),
            )),
        Container(
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.data.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      Text(
                        state.data.voteAverage.toString() +
                            "/10" +
                            "    " +
                            state.data.voteCount.toString() +
                            " Vote",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range_rounded, color: Colors.white),
                      SizedBox(width:5),
                      Text(
                        state.data.releaseDate != null
                            ? DateFormat("MMMM yyyy")
                                .format(state.data.releaseDate!)
                            : "Not released yet",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildText(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
