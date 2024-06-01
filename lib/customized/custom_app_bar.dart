import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/main.dart';

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
          beginOffset: Offset(0, -2),
          child: Row(
            children: [
              Image.asset(
                "lib/assets/images/logos/$img",
                height: 5.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text("$title",
                  textAlign: TextAlign.end, style: TextStyle(fontSize: 20.sp)),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget dashboardbar(context, title, img) {
    Color secondary = Utilities().appColors(context).secondary;
    return AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
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
        title: ComponentSlideIns(
          beginOffset: Offset(0, -2),
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
                      backgroundImage: AssetImage(
                        "lib/assets/images/navs/$img",
                      ),
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
                    child: Icon(
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
                    child: Icon(
                      Icons.notifications_active_rounded,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  PreferredSizeWidget generalbar(context, title) {
    Color secondary = Utilities().appColors(context).secondary;
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
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
                overlayColor: MaterialStateProperty.all(Colors.transparent),
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
          beginOffset: Offset(0, -2),
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
}
