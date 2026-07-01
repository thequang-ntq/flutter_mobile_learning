import 'package:code/models/album.dart';
import 'package:code/services/dio_album_service.dart';
import 'package:flutter/material.dart';

class DioHomePage extends StatefulWidget {
  const DioHomePage({super.key});

  @override
  State<DioHomePage> createState() => _DioHomePageState();
}

class _DioHomePageState extends State<DioHomePage> {
  late Future<List<Album>> futureListAlbums;
  late DioAlbumService dioAlbumService;

  @override
  void initState() {
    super.initState();

    dioAlbumService = DioAlbumService();
    futureListAlbums = dioAlbumService.dioFetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      title: Text("HTTP demo", style: text.headlineSmall),
      centerTitle: true,
      backgroundColor: colors.primary,
    );
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Album>>(
      future: futureListAlbums,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final listAlbums = snapshot.data!;

          return Padding(
            padding: EdgeInsets.fromLTRB(w * 0.1, h * 0.1, w * 0.1, h * 0.1),
            child: listAlbums.isEmpty
                ? Center(child: Text("Empty list!", style: text.headlineSmall))
                : ListView.builder(
                    itemCount: listAlbums.length,
                    itemBuilder: (context, index) {
                      final album = listAlbums[index];

                      return ListTile(
                        key: Key(album.id.toString()),
                        title: Text(album.title, style: text.headlineSmall),
                        subtitle: Text(
                          "UserId: ${album.userId}",
                          style: text.labelLarge,
                        ),
                      );
                    },
                  ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.fromLTRB(w * 0.1, h * 0.1, w * 0.1, h * 0.1),
            child: Center(
              child: Text('${snapshot.error}', style: text.headlineSmall),
            ),
          );
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
