import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

class BookmarkController {
  BookmarkService bookmarkService = BookmarkService();

  Future<List<RecipeModel>> getBookmarkRecipes() async {
    try {
      await bookmarkService.open();
      var data = await bookmarkService.getAllRecipe();
      if (data != null) {
        // print('All recipes: $data');
        await bookmarkService.close();
        return data;
      }
    } catch (error) {
      // print('Error: $error');
    }
    await bookmarkService.close();
    return [];
  }

  addBookmark(RecipeModel recipeModel) async {
    
    try {
      await bookmarkService.open();
      bookmarkService.insert(recipeModel);
      await getBookmarkRecipes();
      await bookmarkService.close();
    } catch (error) {
      // print('Error: $error');
    }
  }

  void removeBookmark(int id)async {
    try {
      await bookmarkService.open();
      bookmarkService.delete(id);
      await getBookmarkRecipes();
      await bookmarkService.close();
    } catch (error) {
      // print('Error: $error');
    }
  }

  // drop() async {
  //   try {
  //     await bookmarkService.drop();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}
