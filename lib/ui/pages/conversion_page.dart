// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer' as dartDev;


import 'package:cryptotest/providers.dart';
import 'package:cryptotest/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/coin_model.dart';

/// The conversion Page.
/// Takes two parameters, the list of coins and the selected coin.
/// the selected coin is the initial coin with which the conversion is done
/// the user has the opportunity to change the coin using the dropdown
class ConvertToNairaPage extends ConsumerStatefulWidget {
  const ConvertToNairaPage({
    Key? key,
    required this.coinList,
    required this.selectedCoin,
  }) : super(key: key);

  final List<CoinModel> coinList;
  final CoinModel selectedCoin;

  @override
  createState() => _ConvertToNairaPageState(selectedCoin);
}

class _ConvertToNairaPageState extends ConsumerState<ConvertToNairaPage> {
  _ConvertToNairaPageState(this.selectedCoin);

  CoinModel selectedCoin;

  /// We set this when we get the dollar rate from the API
  late double _dollarRate;
  final _coinTextController = TextEditingController();
  final _nairaTextController = TextEditingController();

  double _convertToNaira(double quantity) {
    final dollarValue = (quantity * selectedCoin.priceUsd);
    return double.parse((dollarValue * _dollarRate).toStringAsFixed(6));
  }

  double _convertToCrypto(double quantity) {
    final dollarValue = (quantity * selectedCoin.priceUsd);
    return double.parse((dollarValue / _dollarRate).toStringAsFixed(6));
  }

  void onCoinSelected(CoinModel coin) {
    setState(() {
      selectedCoin = coin;
    });
    _nairaTextController.text =
        _convertToNaira(double.parse(_coinTextController.text)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF000000),
          centerTitle: true,
          title: const Text('Conversion'),
        ),
       // backgroundColor: ,
        body: ref.watch(dollarRateProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, trace) {
                dartDev.log(error.toString());
                dartDev.log(trace.toString());
                return const Center(
                    child: Text(
                  'An Error has occurred, Please try again',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ));
              },
              data: (dollarRate) {
                _dollarRate = dollarRate;

                return Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: ScreenWidth(20), vertical: ScreenWidth(20)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _DropdownSelection(

                          coinList: widget.coinList,
                          selectedCoin: selectedCoin,
                          onSelectionChange: onCoinSelected),
                      SizedBox(height: ScreenHeight(30)),
                      Row(
                        children: [
                          _CustomTextField(
                            textController: _coinTextController,
                            label: selectedCoin.name,
                            onChanged: (newValue) {
                              _nairaTextController.text =
                                  _convertToNaira(double.parse(newValue))
                                      .toString();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:ScreenWidth(8) ),
                            child: Text(
                              "=",
                              style: TextStyle(
                                  fontSize: ScreenWidth(30), fontWeight: FontWeight.w800),
                            ),
                          ),
                          _CustomTextField(
                            textController: _nairaTextController,
                            label: 'Naira',
                            onChanged: (newValue) {
                              _coinTextController.text =
                                  _convertToCrypto(double.parse(newValue))
                                      .toString();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text("1 ${selectedCoin.symbol} = ₦${_convertToNaira(1)}"),
                      const SizedBox(height: 5),
                      Text(
                          "1 Naira = ${_convertToCrypto(1)} ${selectedCoin.symbol}"),
                 Spacer(),
                          Row (children: [
          Icon(Icons.info,
          color:Colors.red
          ),
          Text('The *Select Coin* is set to default based on the  coin \n you  click from the homepage,would throw  error \n when changed ',
          style: TextStyle(color: Colors.red),
          )
        ],)
                    ],
                  ),
                );
              },
            ));
  }
}

class _CustomTextField extends StatelessWidget {
  _CustomTextField(
      {Key? key,
      required this.textController,
      required this.label,
      this.onChanged})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final _numericInputFormatter =
      FilteringTextInputFormatter.allow(RegExp('[0-9.,]'));

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: textController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [_numericInputFormatter],
            decoration: const InputDecoration(
              hintText: '0.00',
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 4),
          Text(label)
        ],
      ),
    );
  }
}

class _DropdownSelection extends StatelessWidget {
  const _DropdownSelection(
      {Key? key,
      this.selectedCoin,
      required this.coinList,
      required this.onSelectionChange})
      : super(key: key);

  final CoinModel? selectedCoin;
  final List<CoinModel> coinList;
  final void Function(CoinModel) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Coin",
            style: TextStyle(fontSize: ScreenWidth(14), fontWeight: FontWeight.normal)),
        SizedBox(height: ScreenHeight(10)),
        DropdownButtonFormField<CoinModel>(
          value: selectedCoin,
          icon: const Icon(Icons.arrow_downward),
          iconSize: ScreenWidth(24),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE9E9E9),
              prefixIcon: const Icon(Icons.keyboard_arrow_down),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (newValue) {
            if (newValue != null) {
              onSelectionChange(newValue);
            }
          },
          items: coinList.map<DropdownMenuItem<CoinModel>>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.symbol),
            );
          }).toList(),
        ),

        
      ],
    );
  }
}
