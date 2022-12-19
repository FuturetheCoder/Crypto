// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:cryptotest/models/conversion_arg.dart';
import 'package:cryptotest/utils/pageroute/app_navigation.dart';
import 'package:cryptotest/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/coin_model.dart';
import '../../providers.dart';
import '../../utils/pageroute/navigation_service.dart';


final _boldStyle = TextStyle(fontWeight: FontWeight.bold);


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context, ref) {
     SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF000000),
          centerTitle: true,
          title: const Text('Glade Crypto Assessment'),
        ),
        backgroundColor: Color(0xFF000000),
        body: ref.watch(coinListProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, trace) => Center(
                  child: Text(
                'An Error has occurred, Please try again',
                style: _boldStyle,
              )),
              data: (coinList) {
                if (coinList.isEmpty) {
                  return Center(
                      child: Text('No Data returned', style: _boldStyle));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    return await ref.refresh(coinListProvider);
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2, 
                            crossAxisSpacing: ScreenWidth(5)),
                      itemCount: coinList.length,
                      itemBuilder: (context, idx) {
                        final Color color =
                            Colors.primaries[idx % Colors.primaries.length];
                        final coin = coinList[idx];
                        return GestureDetector(
                            onTap: () {
                              ref.read(navigationServiceProvider).navigateTo(
                                  RouteNames.conversionPage,
                                  arguments:
                                      ConversionPageArguements(coinList, coin));
                            },
                            child: _CoinListTile(coin: coin, color: color));
                      }),
                );
              },
            ));
  }
}



class _CoinListTile extends StatelessWidget {
   _CoinListTile({Key? key, required this.coin, required this.color})
      : super(key: key);

  final CoinModel coin;
  final Color color;





  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left:ScreenWidth(10), right: ScreenWidth(10),
      top: ScreenHeight(10), bottom: ScreenHeight(10)
      ),
      child: Container(
          decoration:  BoxDecoration(
           borderRadius:BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              )
            ),
          height: MediaQuery.of(context).size.height/3.2,
          width: MediaQuery.of(context).size.width/2.5,
          child: Column(
            children: [
              YMargin(ScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    child: Text(coin.name[0]),                  
                  ),
                Text(
            coin.usdPriceStr,
            style: _boldStyle,
          ),
                ],
              ),
              YMargin(ScreenHeight(20)),
            Text(coin.name),
           Text(
            coin.symbol,
            style: TextStyle(color: Colors.black.withOpacity(0.5)),
          ),
          
            ],
          ),
         
      
      ),
    );
  }
}
