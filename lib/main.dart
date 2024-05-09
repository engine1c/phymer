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

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  }); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

var _selectedPageIndex = 0;
final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
 final theme = Theme.of(context);
    return  Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {setState(()=> _selectedPageIndex = value) ;},
        children:const [
        SearchScreen(),
        Scaffold(),
        Scaffold(),
        Scaffold(),
        ],
        ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: theme.primaryColor,
      //   onPressed: () {},
      //   ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex, 
        onTap: _openPage ,
        unselectedItemColor: theme.hintColor,
        selectedItemColor: theme.primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Поиск'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Избранное'),
        BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Стихи'),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Настройки'),
        ],),
    );
  }

  void _openPage(int value) {
    setState(() =>
    _selectedPageIndex = value);
    _pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
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
        const SliverToBoxAdapter(child: SizedBox(height: 16,),),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(width: 16,),
            itemBuilder: (context,index) {
              final rhymes = List.generate(8,(index)=> 'Рифма$index');
           return RhymeHistoryCard(rhymes: rhymes);},
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 16,),),
        SliverList.builder(itemBuilder: 
        (context, index) => const RhymeListCard()
        )
      ],
    );
  }
}

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({
    super.key,
    required this.rhymes,
  });

  final List<String> rhymes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
       width: 200,
       padding: const EdgeInsets.all(16),
       child: Column( 
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('Слово',
           style: theme.textTheme.bodyLarge?.copyWith(
             fontWeight: FontWeight.w700
           ),),
           Wrap(children: rhymes.map((e) => Padding(padding: const EdgeInsets.only(right: 4),
           child: Text(e),)).toList(),
           ),
         ],
       ),
       );
  }
}

class BaseContainer extends StatelessWidget {
  const BaseContainer({super.key, required this.child, required this.width, 
  this.margin, 
  this.padding = const EdgeInsets.only(left: 12)});

final double width;
final EdgeInsets? margin;
final Widget child;
final EdgeInsets padding;

 
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(color: theme.cardColor, 
      borderRadius: BorderRadius.circular(10)
      ), 
      child: child,);
  }
}

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return BaseContainer( 
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      width: double.infinity,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Rhymer',style: theme.textTheme.bodyLarge,),
        IconButton(onPressed: (){}, icon: Icon(Icons.favorite,
        color: theme.hintColor.withOpacity(0.2),))
      ],
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
