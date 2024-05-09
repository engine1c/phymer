import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
const primaryColor = Color(0xFFF82B10);
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
primaryColor: primaryColor,
scaffoldBackgroundColor: const Color(0xffeff1f3),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  }); 

  @override
  Widget build(BuildContext context) {
 
   final theme = Theme.of(context);     
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('APP'),
            //backgroundColor:  theme.primaryColor,
            pinned: true,
            snap: true,
            floating: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize( 
              preferredSize: Size.fromHeight(70),
              child: 
              SearchButton(),
                ),
          ),
          SliverList.builder(itemBuilder: 
          (context, index) => Container(
            width: double.infinity,
            height: 40,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: theme.cardColor),
          )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {},
        ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.hintColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16)                ),
      padding: const EdgeInsets.all(12),
      child: 
      Row(
        children: [
         const Icon(Icons.search_rounded),
         const SizedBox(width: 8,),
          Text('Search...',
          style: TextStyle(
            fontSize: 18,
            color:  theme.hintColor.withOpacity(0.4),
            fontWeight:  FontWeight.w700
          ),
          ),
        ],
      ),
      
      );
  }
}
