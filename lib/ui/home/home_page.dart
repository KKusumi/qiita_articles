import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_qiita_retrofit/ui/home/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(homeViewModelNotifierProvider);
    final articles = ref
        .watch(homeViewModelNotifierProvider.select((value) => value.articles));

    useEffect(() {
      viewModel.fetchArticles();
      return;
    }, []);

    return articles == null
        ? const SizedBox()
        : ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          articles[index].user.profileImageUrl,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text('@' + articles[index].user.id,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      articles[index].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 1, color: Colors.black);
            },
            itemCount: articles.length);
  }
}
