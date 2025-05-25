import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bun_terms_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunTermsAndConditions extends StatelessWidget {
  const BunTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BunPageContainer(
                  color: BunColors.lightbeige,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunBackButton(
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      BunbunHeader(
                        header: "BunBun Mart Terms & Conditions",
                        color: BunColors.black,
                      ),

                      SizedBox(height: 8),
                      BunDivider(
                        color: BunColors.black,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(height: 8),

                      BunbunText(
                        text: "⊹₊⟡⋆.𖥔 ݁ ˖⊹₊⟡⋆₊ ⊹",
                        color: BunColors.navy,
                        size: 18,
                      ),
                      SizedBox(height: 8),

                      Container(
                        padding: EdgeInsets.all(20),
                        width: BunSizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: BunColors.navy,
                        ),

                        child: BunDetailsText(
                          text:
                              "Welcome to the BunBun Family! By hopping into our marketplace, you agree to the following terms that help keep everyone safe, secure, and smiling.",
                          color: BunColors.white,
                        ),
                      ),


                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "1. Bunny-Safe Data Privacy", detailsText: "We take your personal info seriously — like carrot-seriously. Whether you're a buyer or seller, your data (name, email, address, etc.) will only be used for platform-related purposes (like order processing and communication). We never sell or share your data with third-party burrows"),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "2. Seller & Buyer Trust Policy", detailsText: "We aim to create a fluffy cloud of trust between buyers and sellers. That means: \n•  Sellers must provide accurate, honest product details. \n• Buyers must use truthful account information when registering and ordering. \n•  Reviews and messages must be respectful and reflect real experiences."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "3. Paw-sitive Payment Protection", detailsText: "All payments are processed through secure, encrypted systems. Neither buyers nor sellers will see each other’s payment details. We’re all about safe transactions — like paw prints on soft grass."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "4. Secure Bunny Accounts", detailsText: "Your login details (email & password) are your responsibility to keep safe. If we detect suspicious activity (like someone else trying to hop into your account), we may temporarily pause access and alert you immediately."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "5. Product & Listing Rules", detailsText: "Only legal, safe-for-pets, and BunBun-approved items are allowed. We don’t allow: \n• Fake or misleading product listings \n• Harmful pet products \n• Duplicated or spammy entries \nViolators may have their listings or accounts removed without prior notice."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "6. Burrow Behavior Expectations", detailsText: "Treat others in the BunBun community with kindness — we’re a family! We do not tolerate: \n• Harassment \n• Scamming \n• Offensive language \nViolations will lead to temporary or permanent suspension of your account."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "7. Changes to the Nest (Policy Updates)", detailsText: "We may update our terms from time to time to keep the nest neat. If we do, we’ll give you a heads-up via email or in-app notices. Your continued use means you accept the updated policies."),
                      SizedBox(height: 16),
                      BunTermsContainer(mainText: "8. Contacting the BunBun Team", detailsText: "Questions? Concerns? A curious sniff? You can always reach out to us via our Support Page. We’re here to help you every hop of the way."),
                      SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
