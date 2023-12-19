import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchTec;

  @override
  void initState() {
    super.initState();
    _searchTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchTec.dispose();
  }

  _handleClearSearch() => _searchTec.clear();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text("Search", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _searchTec,
                    style: GoogleFonts.karla(
                        color: Theme.of(context).colorScheme.onTertiary,
                        decorationThickness: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        hintText: "What to do you want to see?",
                        prefixIconColor:
                            Theme.of(context).colorScheme.onTertiary,
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _handleClearSearch)),
                  ),
                ),
              ),

              const SizedBox(height: 18),
              // TODO : 추천 유저 보여주기
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (context, index) => ListTile(
                          leading: const CircleAvatar(),
                          title: Text("Username",
                              style: GoogleFonts.lobster(
                                  fontWeight: FontWeight.bold)),
                          subtitle: const Text("#test1 #test2"),
                          trailing: ElevatedButton(
                              onPressed: () {}, child: const Text("Follow")),
                        ),
                    separatorBuilder: (_, __) =>
                        const Divider(indent: 30, endIndent: 30)),
              )
            ],
          ),
        ),
      );
}
