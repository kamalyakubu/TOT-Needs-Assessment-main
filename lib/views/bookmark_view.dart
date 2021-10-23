import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmark_controller.dart';
import 'package:recipe_app/model/recipe_model.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  final BookmarkController bookmarkController = BookmarkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: FutureBuilder(
        future: bookmarkController.getBookmarkRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          List<RecipeModel> recipeModels = snapshot.data as List<RecipeModel>;
          return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.blueAccent,);
              },
              itemCount: recipeModels.length,
              itemBuilder: (BuildContext context, int index) {
                RecipeModel recipeModel = recipeModels[index];

                return ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      recipeModel.image,
                    ),
                  ),
                  title: Text(
                    recipeModel.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    recipeModel.category,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15),
                  ),
                  trailing: Icon(Icons.delete, color: Colors.red,),
                  onTap: () {
                    bookmarkController.removeBookmark(recipeModel.id!);
                  },
                );
              });
        },
      ),
    );
  }
}
