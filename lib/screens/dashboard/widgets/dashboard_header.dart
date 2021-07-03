import 'package:flutter/material.dart';

import '../../../constants.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Container(
      height: height * .2,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding * 1.5),
          child: TextFormField(
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: kPrimaryTextColor, fontSize: 17),
            decoration: InputDecoration(
                hintText: 'Create a new loan banner',
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kPrimaryTextColor.withOpacity(0.5), fontSize: 17),
                suffixIcon: Icon(
                  Icons.navigate_next,
                  color: kPrimaryTextColor,
                )),
          ),
          decoration: BoxDecoration(
            color: kPrimaryDarkColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
