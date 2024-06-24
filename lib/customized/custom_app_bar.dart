import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CustomAppBar {
  CustomAppBar();

  PreferredSizeWidget welcomebar(context, title) {
    // Color secondary = Utilities().appColors(context).secondary;

    return AppBar(
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Divider(
          height: 12,
          thickness: 12,
          color: Colors.white,
        ),
      ),
      automaticallyImplyLeading: false,
      // foregroundColor: secondary,
      title: Consumer(builder: (context, ref, child) {
        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        String img = selectedTheme == darkTheme
            ? "logo-icon-dark.png"
            : "logo-icon-light.png";
        return ComponentSlideIns(
          beginOffset: const Offset(0, -2),
          child: Row(
            children: [
              Image.asset(
                "lib/assets/images/logos/$img",
                height: 5.h,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("$title",
                  textAlign: TextAlign.end, style: TextStyle(fontSize: 20.sp)),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget dashboardbar(context, title) {
    String api = "http://10.0.2.2:8000";

    Color secondary = Utilities().appColors(context).secondary;
    return AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Consumer(builder: (context, ref, child) {
            final selectedTheme = ref.watch(AppThemeProvider)["theme"];
            Color dividerColor =
                selectedTheme == darkTheme ? Colors.white : secondary;

            return Divider(
              height: 12,
              thickness: 12,
              color: dividerColor,
            );
          }),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, _) {
            final user = ref.watch(userProvider.notifier).state;
            final profile = user.image;
            final defaultImage = profile ?? "road.jpg";

            return ComponentSlideIns(
              beginOffset: const Offset(0, -2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "user");
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: profile == null
                              ? AssetImage(
                                      "lib/assets/images/cards/$defaultImage")
                                  as ImageProvider
                              : NetworkImage("$api/UserProfile/$profile"),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text("$title",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 19.sp)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "favs");
                        },
                        child: const Icon(
                          Icons.favorite_rounded,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "notify");
                        },
                        child: const Icon(
                          Icons.notifications_active_rounded,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }

  PreferredSizeWidget generalbar(context, title) {
    Color secondary = Utilities().appColors(context).secondary;
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Consumer(builder: (context, ref, child) {
          final selectedTheme = ref.watch(AppThemeProvider)["theme"];
          Color dividerColor =
              selectedTheme == darkTheme ? Colors.white : secondary;

          return Divider(
            height: 12,
            thickness: 12,
            color: dividerColor,
          );
        }),
      ),
      centerTitle: true,
      leading: Navigator.of(context).canPop()
          ? TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
                color: secondary,
              ),
            )
          : null,
      // foregroundColor: secondary,
      title: Consumer(builder: (context, ref, child) {
        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        String img = selectedTheme == darkTheme
            ? "logo-icon-dark.png"
            : "logo-icon-light.png";

        return ComponentSlideIns(
          beginOffset: const Offset(0, -2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$title",
                  textAlign: TextAlign.end, style: TextStyle(fontSize: 20.sp)),
              Image.asset(
                "lib/assets/images/logos/$img",
                height: 5.h,
              ),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget bgImgbar(context, title) {
    Color black = Colors.black;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 5,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Divider(
          height: 12,
          thickness: 12,
          color: black,
        ),
      ),
      centerTitle: true,
      leading: Navigator.of(context).canPop()
          ? TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
                color: black,
              ),
            )
          : null,
      title: ComponentSlideIns(
        beginOffset: const Offset(0, -2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 20.sp, color: black)),
          ],
        ),
      ),
    );
  }
}
