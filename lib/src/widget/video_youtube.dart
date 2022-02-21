import 'package:app_movies/provider/movies_provider.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayCustome extends StatefulWidget {
  const VideoPlayCustome(
      {Key? key, required this.movieProvider, required this.keyVideo})
      : super(key: key);

  final ProviderMovie movieProvider;
  final String keyVideo;

  @override
  State<VideoPlayCustome> createState() => _VideoPlayCustomeState();
}

class _VideoPlayCustomeState extends State<VideoPlayCustome> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.keyVideo,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      children: [
        YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  // some widgets
                  player,
                  //some other widgets
                ],
              );
            }),
        IconButton(
            onPressed: () {
              widget.movieProvider.isClosedVide();
            },
            icon: const Icon(Icons.close, color: Colors.white, size: 20)),
      ],
    ));
  }
}
