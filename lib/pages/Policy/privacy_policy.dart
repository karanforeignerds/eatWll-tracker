import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            title: "Privacy Policy",
            backNavigation: true,
            profile: true,
          ),
          SizedBox(height: 24,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Privacy Policy",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.greyBlack,
                    ),
                    SizedBox(height: 16,),
                    CustomText(
                      align: TextAlign.justify,
                      text:
                          "Lörem ipsum mihaskapet. Intrar nirade. Stenoledes tusäska jore. Spim serieotrohet, megan. Du kan vara drabbad."
                          "Ner autodick operasofi tills nyr, prehis. Planoliga plamåning fäv makrogon plasoling. Tetrara. Kroföde eurosam, efäde."
                          "Soktig lysade semiv fara kore. Gifas pebelt speren gider bepåjanat. Räda. Negt desdiktisk, prera i prement som sede."
                          "Böledes posam tebel har. Prelig anaderar medan mant. Påde dekasamma. Hisat."
                          "Preda spenade. Falän cringe tepyrar, behet. Areliga dedihinar. Öskade vätrena lade buska diafögt."
                          "Nosamma nunt kvasipynar deskade infrarade. Antihir dide angar, prodehide ponebel. Föburade teröde äd. Son dogisk."
                          "Nyföska krolyn. Renivis dining biomill. Mihil hehilogi, gölingar notunera. Antel föktig kal saligt.",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
