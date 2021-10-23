import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/controller/bookmark_controller.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/views/video_player_view.dart';

class DetialViewExample extends StatelessWidget {
  DetialViewExample({
    Key? key,
    required this.model,
  }) : super(key: key);

  final BookmarkController bookmarkController = BookmarkController();

  final RecipeModel model;
  double? rate;

  @override
  Widget build(BuildContext context) {
    rate = model.rate;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(
              model.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white12,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerView(videoUrl: model.video),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 60,
                    ),
                  ),
                  radius: 40,
                ),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
                  elevation: 0,
                  margin: const EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90)),
                          ),
                        ),
                        Text(
                          model.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              'category',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$rate',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.6),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Ingredent ingredent = model.ingredents[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ingredent.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        ingredent.quantity,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                itemCount: model.ingredents.length),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey.shade300)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BackButton(),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await bookmarkController.addBookmark(model);
                        // await bookmarkController.drop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.bookmark_border_outlined),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.grey.shade300))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
