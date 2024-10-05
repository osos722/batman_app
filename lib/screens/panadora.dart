import 'package:failed4/productivity_cupit/app_states.dart';
import 'package:failed4/repeatedvalues/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../productivity_cupit/productivity_cupit.dart';
class panadora extends StatelessWidget {
  int min2 = 1;
  int sec2 = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Using Expanded to give proper space to the Pickers
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                // Minutes Picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int index) {
                      min2 = index; // Update minute
                    },
                    children: List<Widget>.generate(
                      60,
                          (int index) {
                        return Center(
                          child: Text(
                            '$index',
                            style: TextStyle(
                              fontSize: 30,
                              color: textcolor,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 40, color: textcolor),
                ),
                // Seconds Picker
                    Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int index2) {
                        sec2 = index2; // Update second
                      },
                      children: List<Widget>.generate(
                        60,
                            (index2) {
                          return Center(
                            child: Text(
                              "$index2",
                              style: TextStyle(
                                color: textcolor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),]
                ),

            ),
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Color(0xff697565),
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {
                  // Use WidgetsBinding to safely start the count after the layout is complete
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<pro_cupit>().start_the_count(min2, sec2);
                  });
                },
                child: Text(
                  "Start",
                  style: TextStyle(
                    color: textcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 230),
          BlocBuilder<pro_cupit, big_states>(
            builder: (context, state) {
              if (state is start_count) {
                return Center(
                  child: Text(
                    "${state.min}:${state.sec}",
                    style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                        color:Color(0xffECDFCC)
                    ),
                  ),
                );
              } else {
                return Text(
                  "00:00",
                  style: TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffECDFCC)
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
