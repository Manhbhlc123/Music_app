import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/search/controller/Search_controller.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Search_history_section.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Trending_keyword_section.dart';

class SearchView extends GetView<SearchControllerHome> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverAppBar(floating: true, title: Text("Tìm kiếm")),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SearchBar(
                      hintText: "Tìm kiếm bài hát, nghệ sĩ...",
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          controller.search(value);
                          Get.toNamed(Routes.searchResult, arguments: value);
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    Obx(() {
                      if (controller.histories.isEmpty)
                        return const SizedBox.shrink();
                      return SearchHistorySection(
                        historyItems: controller.histories,
                        onTapItem: (value) {
                          controller.search(value);
                          Get.toNamed(Routes.searchResult, arguments: value);
                        },
                        onClearAll: controller.clearHistory,
                      );
                    }),

                    const SizedBox(height: 20),

                    Obx(() {
                      if (controller.trendingKeywords.isEmpty)
                        return const SizedBox.shrink();
                      return TrendingKeywordSection(
                        items: controller.trendingKeywords,
                        onTapItem: (value) {
                          controller.search(value);
                          Get.toNamed(Routes.searchResult, arguments: value);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        onRefresh: () async {
          await controller.loadHistory();
          await controller.loadTrending();
        },
      ),
    );
  }
}
