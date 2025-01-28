import 'package:flutter/material.dart';
import 'package:frontend/models/transaction.dart';
import 'package:frontend/pages/card_details_page.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:frontend/providers/card_provider.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  
  @override
    Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // print(isDarkMode);
    Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          "Transactions",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(1, 104, 170, 1),
          ),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: FutureBuilder(
                            future: context.read<VCardsProvider>().getAllTransactions(),
                            builder: (context, dataSnapshot) {
                              if (dataSnapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                              return Consumer<VCardsProvider>(
                                builder: (context, provider, _) {
                                  return Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(height: 10,),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Details",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(1, 104, 170, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: provider.allTransactions.length,
                                          itemBuilder: (context, index) {
                                            // return createTile(
                                            //   title: provider.title[index], 
                                            //   total: provider.spent[provider.categories[index]], 
                                            //   limit: provider.budget[provider.categories[index]]
                                            // );
                                            return TransactionCard(transaction: provider.allTransactions[index]);
                                          }
                                        )
                                      ),
                                    ],
                                  );
                                }
                              );
                            }
                          ),
                        ),
                        const SizedBox(height: 130,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
        );
  }
}

Widget createTile({required String title, required int total, required int limit}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontSize: 15),),
    subtitle: SizedBox(
      height: 5,
      width: 10,
      child: LinearProgressBar(
        maxSteps: 100,
        progressType: LinearProgressBar
            .progressTypeLinear,
        currentStep: (total / limit * 100).toInt(),
        progressColor: Colors.blue.shade800,
        backgroundColor: const Color.fromRGBO(223, 222, 222, 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$total KD', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        Text('Limit $limit KD', style: const TextStyle(fontSize: 12),)
      ],
    ),
  );
}