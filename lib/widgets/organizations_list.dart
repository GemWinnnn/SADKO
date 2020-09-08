import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/organizations_logo.dart';

class OrganizationsList extends StatefulWidget {
  OrganizationsList({Key key}) : super(key: key);

  @override
  _OrganizationsListState createState() => _OrganizationsListState();
}

class _OrganizationsListState extends State<OrganizationsList> {
  GlobalKey<ScrollSnapListState> sslKeyOrganizations = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<OrganizationsBloc>(context).add(OrganizationsRequested());

    return Container(
        child: SizedBox(
            height: 200,
            width: double.infinity,
            child: BlocBuilder<OrganizationsBloc, OrganizationsState>(
              builder: (context, state) {
                if (state is OrganizationsLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is OrganizationsLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 400,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.organizations.length
                          ? Text("Bottom Loader")
                          : OrganizationsLogo(
                              height: 100,
                              width: 140,
                              name: state.organizations[index].name,
                              description:
                                  state.organizations[index].description,
                              logo: apiUrl +
                                  state.organizations[index].logo["url"],
                            );
                    },
                    itemCount: state.organizations.length,
                    key: sslKeyOrganizations,
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
