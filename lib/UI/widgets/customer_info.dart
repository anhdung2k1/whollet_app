import 'package:flutter/material.dart';
import 'package:whollet_app/UI/constant/constant.dart';

class CustomUserInfo extends StatelessWidget {

  final bool isBalance;
  final String firstName, lastName;
  final double balance;
  final Function pressShowHide;
  final Function pressCreateWallet;
  const CustomUserInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    this.balance = .0,
    required this.isBalance,
    required this.pressShowHide,
    required this.pressCreateWallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => pressShowHide(),
                    child: isBalance
                        ? Text("Hide Balance", style: TextStyle(fontSize: 20,color: Color(0xFF6F35A5)))
                        : Text("Show Balance", style: TextStyle(fontSize: 20,color: Color(0xFF6F35A5))),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => pressCreateWallet(),
                    child: Text("Create Wallet", style: TextStyle(fontSize: 20,color: Color(0xFF6F35A5)),),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  height: size.height * 0.07,
                  width: size.width - 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: wPrimaryBlue.withOpacity(0.5),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "${isBalance ? (balance).toStringAsFixed(4) : "********"} ICX",
                          style: TextStyle(
                            fontSize: size.width * .06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${isBalance ? (balance * 1.49).toStringAsFixed(4) : "********"} \$",
                          style: TextStyle(
                            fontSize: size.width * .06,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
