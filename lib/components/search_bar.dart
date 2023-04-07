import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/db_helper_database.dart';
class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.onSearched}) : super(key: key);
final Function(dynamic text) onSearched;
  @override
  State<SearchBar> createState() => _SearchBarState(onSearched);
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  
  bool _isActive = false;
  String _searchText = "";
  DbHelperDatabase? dbHelper;
  List<Map<String, dynamic>>? _searchResult;
  
  _SearchBarState(  this.onSearched);
  final Function(dynamic text) onSearched;
 void _onTextChanged(String value) async {
  onSearched(value);
    
    // setState(() {
    //   _searchText = value;
    // });

    // final List<Map<String, dynamic>> result = await DbHelperDatabase.instance.search(_searchText);
    // print("arama sayfası : ${result.toString()}" );

    // Burada gelen sonuçları kullanabilirsiniz
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isActive)
         Text("Rss Follower", style: GoogleFonts.taiHeritagePro(fontSize: 30,),),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: _isActive
                  ? Container(
                      decoration: BoxDecoration(
                          
                          //borderRadius: BorderRadius.circular(10.0)
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                            hintText: 'Arama Yapmak İçin Bir Şey Yazın',
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.search,color: Colors.white),
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onChanged: _onTextChanged,
                        )
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isActive = false;
                                _searchResult = null;
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      icon: const Icon(Icons.search),
                    ),
            ),
          ),
        ),
        if (_searchResult != null)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResult!.length,
              itemBuilder: (context, index) {
                final result = _searchResult![index];
                return ListTile(
                  subtitle: Text(result["WordOne"]),
                  title: Text(result['WordTwo'],),
                );
              },
            ),
          ),
      ],
    );
  }
}