import 'package:flutter/material.dart';
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
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBarWidgets(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PrayerTimesProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  TextField(
                    controller: provider.searchController,
                    decoration: InputDecoration(
                      hintText: 'Şehir/ilçe ara (örn: Ankara)',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          provider.searchController.text.isNotEmpty
                              ? IconButton(icon: const Icon(Icons.clear), onPressed: provider.clearSearch)
                              : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey), // istediğin renk
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
        child: Text(
          provider.searchController.text.isEmpty ? 'Arama yapmak için en az 3 karakter girin' : 'Sonuç bulunamadı',
          style: const TextStyle(fontSize: 18),
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
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.purpleColor),
            child: ListTile(
              title: Text(
                location['name'],
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                '${location['stateName']} • ${location['country']}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.w400, fontSize: 14),
              ),
              onTap: () async {
                await provider.fetchPrayerTimes(location['id'].toString());
                if (provider.prayerData != null) {
                  Navigator.pop(context, {'place': provider.selectedLocation, 'times': provider.prayerData!['times']});
                }
              },
            ),
          ),
        );
      },
    );
  }
}
