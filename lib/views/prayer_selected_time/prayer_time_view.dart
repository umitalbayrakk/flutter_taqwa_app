import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_taqwa_app/app/controllers/prayer_times_provider.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrayerTimesProvider(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBarWidgets(showBackButton: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PrayerTimesProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  TextField(
                    controller: provider.searchController,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      hintText: 'Şehir/ilçe ara (örn: Ankara)',
                      prefixIcon: Icon(FeatherIcons.search, color: Theme.of(context).iconTheme.color),
                      suffixIcon:
                          provider.searchController.text.isNotEmpty
                              ? IconButton(icon: const Icon(Icons.clear), onPressed: provider.clearSearch)
                              : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (provider.isLoading) const LinearProgressIndicator(),
                  if (provider.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red, fontSize: 16)),
                    ),
                  Expanded(child: _buildMainContent(context, provider)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, PrayerTimesProvider provider) {
    if (provider.locations.isNotEmpty) {
      return _buildLocationsList(context, provider);
    } else {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset("assets/svg/Frame 22.svg", color: AppColors.greenColor, width: 80, height: 80),
            SvgPicture.asset("assets/svg/Frame 21.svg", color: AppColors.greenColor, width: 80, height: 80),
            SvgPicture.asset("assets/svg/Group 20.svg", color: AppColors.greenColor, width: 80, height: 80),
          ],
        ),
      );
    }
  }

  Widget _buildLocationsList(BuildContext context, PrayerTimesProvider provider) {
    return ListView.builder(
      itemCount: provider.locations.length,
      itemBuilder: (context, index) {
        final location = provider.locations[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(
              location['name'],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              '${location['stateName']} • ${location['country']}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            ),
            onTap: () async {
              await provider.fetchPrayerTimes(location['id'].toString());
              if (provider.prayerData != null) {
                Navigator.pop(context, {'place': provider.selectedLocation, 'times': provider.prayerData!['times']});
                Navigator.popUntil(context, ModalRoute.withName('/customnavbarwidgets'));
              }
            },
          ),
        );
      },
    );
  }
}
