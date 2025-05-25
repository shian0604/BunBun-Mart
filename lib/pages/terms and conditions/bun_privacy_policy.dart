import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bun_terms_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunPrivacyPolicy extends StatelessWidget {
  const BunPrivacyPolicy({super.key});

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
                        header: "Privacy Paw-licy",
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
                              "At BunBun Mart, we’re not just about carts, cuddles, and cuteness — we’re also serious about keeping your information safe and secure. Whether you're a buyer or a seller, you are part of our bun-beloved family, and your trust means everything to us. 💌\n Below is our privacy promise, explained in easy nibbles:",
                          color: BunColors.white,
                        ),
                      ),

                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "1. 🧺 What We Collect (With Love)",
                        detailsText:
                            "To make your shopping experience smooth and joyful, we may collect:\n• Your name and contact details (like email & phone number)\n• Shipping addresses (for delivery of fur-tastic goodies)\n• Login credentials and account preferences\n• Product listings and transactions (for our seller buns!)\n• Feedback, reviews, and adorable profile pics 🐶🐱",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "2. 🔒 How We Keep It Safe",
                        detailsText:
                            "We use secure technologies to:\n• Encrypt your data during transfers (bunny-proof protection!)\n• Store your info in locked-down, secure databases\n• Limit access only to trusted BunBun staff\nNo sneaky paws allowed! 🐾",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "3. 🚫 What We Never Do",
                        detailsText:
                            "We never:\n• Sell your information to outside carrot-chasing companies\n• Share your data without your clear permission\n• Spam your inbox with junk (only the cutest updates & offers!)",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "4. 💕 Why We Use Your Data",
                        detailsText:
                            "We use your info to:\n• Process orders and deliver your pet's must-haves\n• Keep your account bun-tastic and up-to-date\n• Improve BunBun Mart to serve you better\n• Send gentle reminders, paw-some promos, and helpful updates",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "5. 🐇 Your Control & Choices",
                        detailsText:
                            "You’re always in charge of your bunformation!\n• You can update your account anytime\n• You can opt-out of email newsletters with a single click\n• You can request data deletion if you wish to hop away (we’ll miss you though 💔)",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "6. 🌎 Cookies? Only the Digital Kind 🍪",
                        detailsText:
                            "We use cookies to:\n• Keep you logged in smoothly\n• Save your cart and preferences\n• Understand what products make your tail wag\nYou can always manage or disable cookies in your browser settings.",
                      ),
                      SizedBox(height: 16),
                      BunTermsContainer(
                        mainText: "7. 📨 Questions or Concerns? Let’s Talk!",
                        detailsText:
                            "We’re all ears! 🐰\nIf you have any worries or questions about your data, please email us at:\n📩 support@bunbunmart.com",
                      ),
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
