import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/review.dart';
import '../../models/rate.dart';
import '../../providers/insights_provider.dart';
import '../../style/fonts.dart';

String data = '';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  int page = 0;
  int limit = 10;
  late ScrollController controller = ScrollController()
    ..addListener(fetchItems);

  void fetchItems() async {
    final insights = context.read<InsightsProvider>();
    double offset = controller.offset;
    if (insights.state.isFetching()) return;
    if (offset >= controller.position.maxScrollExtent &&
        !insights.state.isFinale()) {
      await insights.fetchInsights(page: ++page, limit: limit);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients) controller.jumpTo(offset + 500);
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(fetchItems);
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context
        .read<InsightsProvider>()
        .fetchInsights(page: page, limit: limit));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InsightsProvider>(builder: (context, insights, _) {
      return Scaffold(
        appBar: insights.state.isInitializing()
            ? null
            : AppBar(
                automaticallyImplyLeading: true,
                leadingWidth: 72.0,
                title: Text("Customer Insights", style: Fonts.appBarTitle),
              ),
        body: insights.state.isInitializing() || insights.list.isEmpty
            ? _buildLoading(context)
            : ListView.builder(
                controller: controller,
                itemCount: insights.list.length,
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                itemBuilder: (context, index) =>
                    Review(rate: insights.list[index]),
              ),
      );
    });
  }

  Shimmer _buildLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: AbsorbPointer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 56),
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.chevron_left_outlined, size: 36.0),
                SizedBox(width: MediaQuery.of(context).size.width / 4),
                Text("Customer Insights",
                    style: Fonts.appBarTitle, textAlign: TextAlign.center),
              ],
            ),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Review(
                  rate: Rate(
                    name: 'User Name',
                    date: 'Date',
                    overallRating: 5,
                    hygiene: 1,
                    ambience: 2,
                    quality: 3,
                    taste: 4,
                    comment: data,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({super.key, required this.rate});

  final Rate rate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Customer Insights", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Text('Overall Rating', style: Fonts.appBarTitle),
            RatingsFactor(stars: rate.overallRating),
            const SizedBox(height: 8.0),
            RatingsFactor(text: 'Hygiene', stars: rate.hygiene),
            RatingsFactor(text: 'Taste', stars: rate.taste),
            RatingsFactor(text: 'Quality', stars: rate.quality),
            RatingsFactor(text: 'Ambience', stars: rate.ambience),
            const SizedBox(height: 24.0),
            Text(rate.comment,
                style: Fonts.hintText, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
