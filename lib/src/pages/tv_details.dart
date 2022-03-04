import 'package:app_movies/model/model_tv.dart';
import 'package:app_movies/model/model_tv_details.dart';
import 'package:app_movies/src/widget/card_casting.dart';
import 'package:flutter/material.dart';

class TvDetailsPages extends StatefulWidget {
  const TvDetailsPages(
      {Key? key, required this.tvSeries, required this.tvDetails})
      : super(key: key);
  final TV tvSeries;
  final ModelTvDeatis tvDetails;

  @override
  State<TvDetailsPages> createState() => _TvDetailsPagesState();
}

class _TvDetailsPagesState extends State<TvDetailsPages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: widget.tvDetails.seasons.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tvSeries.id);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            _SliverApp(tvDetails: widget.tvDetails, size: size),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.tvDetails.firstAirDate,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' Episodios ${widget.tvDetails.numberOfEpisodes.toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' Temporadas ${widget.tvDetails.numberOfSeasons.toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Descripcción',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Text(widget.tvDetails.overview!,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              // Cast
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardCastingTV(idTV: widget.tvSeries.id.toString()),
              ),

              // Tabbar
              SizedBox(
                height: 50,
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    tabs: List.generate(
                        widget.tvDetails.seasons.length,
                        (index) =>
                            Text(widget.tvDetails.seasons[index].name!))),
              ),
              // TabView
              SizedBox(
                height: 250,
                child: TabBarView(
                    controller: _tabController,
                    children:
                        List.generate(widget.tvDetails.seasons.length, (index) {
                      final season = widget.tvDetails.seasons[index];
                      return Row(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder:
                                      const AssetImage('assets/loading.gif'),
                                  image: NetworkImage(season.fullProfilePath)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ListView(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Episodios ${season.episodeCount!.toString()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                if (season.airDate != null)
                                  Text(
                                    season.airDate!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  season.overview!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    })),
              )
            ]))
          ],
        ));
  }
}

class _SliverApp extends StatelessWidget {
  const _SliverApp({
    Key? key,
    required this.tvDetails,
    required this.size,
  }) : super(key: key);

  final ModelTvDeatis tvDetails;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(tvDetails.name),
        background: Stack(
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${tvDetails.backdropPath}'),
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 120,
                width: size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                      0,
                      0.5,
                      1
                    ],
                        colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black
                    ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
