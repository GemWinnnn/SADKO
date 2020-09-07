import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/message_card.dart';

class MessagesList extends StatefulWidget {
  MessagesList({Key key}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  GlobalKey<ScrollSnapListState> sslKeyMessages = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<MessagesBloc>(context).add(MessagesRequested());

    double _cardHeight = appScreenSize.height * 0.5;

    return Container(
        child: SizedBox(
            height: appScreenSize.height * 0.5,
            width: double.infinity,
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is MessagesLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint(state.messages[0].toString());
                      return index >= state.messages.length
                          ? Text("Bottom Loader")
                          : MessageCard(
                              height: _cardHeight,
                              width: 300,
                              name: state.messages[index].name,
                              description: state.messages[index].description,
                              messageBody: state.messages[index].messageBody,
                              featuredImage: apiUrl +
                                  state.messages[index].featuredImage["url"],
                            );
                    },
                    itemCount: state.messages.length,
                    key: sslKeyMessages,
                  );
                }

                return Container(
                    width: appScreenSize.width,
                    height: appScreenSize.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ));
              },
            )));
  }
}
