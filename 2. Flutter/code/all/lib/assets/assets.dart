import 'package:code_learning_flutter/assets/assets_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAssets extends StatelessWidget {
  const MyAssets({super.key});

  Future<String> _readFile() async {
    return await rootBundle.loadString(AssetsConfig.jsonFile);
  }

  Future<void> _showModal(BuildContext context) async {
    final text = Theme.of(context).textTheme;
    final fileContent = await _readFile();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("File content", style: text.headlineSmall),
          content: SingleChildScrollView(
            child: Text(fileContent, style: text.labelLarge),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: text.labelLarge),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.primary,
      title: Text("Assets demo", style: text.headlineSmall),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AssetsConfig.gridCrossAxisCount,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Image(
          fit: BoxFit.cover,
          image: AssetImage(AssetsConfig.getGridImage(index)),
        );
      },
      physics: ClampingScrollPhysics(),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await _showModal(context);
      },
      child: Icon(Icons.file_open),
    );
  }
}
