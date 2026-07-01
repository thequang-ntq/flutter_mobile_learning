import 'package:code/models/album.dart';
import 'package:code/services/http_album_service.dart';
import 'package:flutter/material.dart';

class HttpHomePage extends StatefulWidget {
  const HttpHomePage({super.key});

  @override
  State<HttpHomePage> createState() => _HttpHomePageState();
}

class _HttpHomePageState extends State<HttpHomePage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();

    futureAlbum = httpFetchAlbum();
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

    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text(snapshot.data!.title, style: text.headlineSmall),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}', style: text.headlineSmall),
          );
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
