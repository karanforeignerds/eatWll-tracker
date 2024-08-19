import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TermsOfServices extends StatelessWidget {
  const TermsOfServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            profile: true,
            title: "Terms of use & Privacy Policy",
            backNavigation: true,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Documents").doc('termPrivacyPolicy').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.data!.exists){
                  return noDataExits();
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "TERMS OF USE AND PRIVACY POLICY",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greyBlack,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ///SCOPE OF TERMS & CONDITIONS===================
                        CustomText(
                          align: TextAlign.justify,
                          text: snapshot.data!['data'],
                          color: AppColors.greyBlack,

                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
  noDataExits() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "TERMS OF USE AND PRIVACY POLICY",
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.greyBlack,
            ),
            const SizedBox(
              height: 16,
            ),
            ///SCOPE OF TERMS & CONDITIONS===================

            const CustomText(
                      align: TextAlign.justify,
                      text:"""

1. SCOPE OF TERMS & CONDITIONS
                                           
Unless otherwise indicated, these Terms and Conditions of Service (“Terms & Conditions”) apply to (i) your use of and/or access to the EatWellTracker.com website and/or other websites (collectively, “Website”) which are owned or operated by Eat Well Tracker, LLC. or its affiliates (collectively, “Eat Well Tracker”, “we,” “us,” or “our”), including any portions thereof available only to subscribers, and (ii) your use of and/or access to the mobile phone applications which we may own or operate currently or in the future (collectively, the “Mobile App”) and (iii) your use of and or access to any content or information and other online or mobile-enabled technology, digital tools and other services and products provided by us (together with the Website and the Mobile App, collectively, the “Services”). For purposes of these Terms & Conditions, “affiliates” shall mean any entity or person, directly or indirectly, owning a controlling interest in, owned by, or under common ownership control with, Eat Well Tracker. The term “Mobile App” shall refer to both the Basic Service and Premium Services (hereinafter defined).\n

We are committed to protecting your privacy and security. For more information, you should review our Privacy Policy HIPAA Notice, which are incorporated into these Terms & Conditions by this reference.\n

IF YOU ARE NOT WILLING TO BE OR CANNOT BE BOUND BY ALL OF THESE TERMS AND CONDITIONS, INCLUDING WITHOUT LIMITATION THE FOLLOWING AGREEMENT AND ACKNOWLEDGEMENT, THEN DO NOT ACCESS, BROWSE OR USE THE SERVICES. MOREOVER, EAT WELL TRACKER DOES NOT AND WILL NOT GRANT YOU ANY RIGHT OR LICENSE TO ACCESS, BROWSE OR THE SERVICES WITHOUT YOUR WILLINGNESS AND ABILITY TO BE BOUND BY ALL OF THE TERMS AND CONDITIONS OF THIS AGREEMENT.\n

IF YOU DO NOT ABIDE BY THE PROVISIONS OF THESE TERMS & CONDITIONS, EXCEPT AS WE MAY OTHERWISE PROVIDE FROM TIME TO TIME, YOU AGREE THAT WE MAY IMMEDIATELY DEACTIVATE OR DELETE YOUR USER ACCOUNT AND ALL RELATED INFORMATION AND FILES IN YOUR USER ACCOUNT AND/OR RESTRICT ANY FURTHER ACCESS TO SUCH INFORMATION AND/OR FILES, OR OUR SERVICES, WITH OR WITHOUT NOTICE.\n

You must exercise caution, good sense and sound judgment in using the Services. You are prohibited from violating, or attempting to violate, the security of the Services. Any such violations may result in criminal and/or civil penalties against you. Eat Well Tracker will investigate any alleged or suspected violations and if a criminal violation is suspected, we may contact and/or cooperate with law enforcement agencies in their investigations.\n

""",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    const CustomText(
                      align: TextAlign.justify,
                      text:"""2. AGREEMENT AND ACKNOWLEDGEMENT

a. User Agreement. By using the Services, you accept these Terms & Conditions and agree to be legally bound and to abide by the terms, conditions, and notices contained or referenced herein, just as if you had signed them.


b. Changes to Terms & Conditions. From time to time, we may, in our sole discretion, change, modify, supplement or remove portions of these Terms & Conditions (“Additional Terms”). Such Additional Terms shall become effective upon posting by the Company on the Website, the Mobile App, via the Service or sending you an email or other notification. You will be deemed to have agreed to such Additional Terms by your decision to continue accessing the Mobile App or the Website or otherwise using any of the Services following the date in which such Additional Terms become effective.


c. Modification of Services. In our sole discretion and without prior notice or liability, we may discontinue, modify or alter any aspect of the Services provided to you, including, but not limited to, (i) restricting the time the Services are available, (ii) restricting the amount of use permitted, (iii) restricting or terminating any user’s right to use the Services and (iv) changing any feature or functionality provided by the Services. You agree that any termination or cancellation of your access to, or use of, the Services may be affected without prior notice. Further, you agree that we shall not be liable to you or any third-party for any termination or cancellation of your access to, or use of, our Services.


d. Downloading Mobile App. You may access the Mobile App which can be downloaded from an applications store or applications distribution platform, such as the Apple Mobile App Store or Google Play, (the “Mobile App Provider”). You acknowledge and agree that: (i) these Terms & Conditions are entered into between us, and not with the Mobile App Provider, and that we are solely responsible for the Mobile App (not the Mobile App Provider); (ii) the Mobile App Provider has no obligation to furnish any maintenance and support services with respect to the Mobile App; (iii) the Mobile App Provider is not responsible for addressing any claims you have or any claims of any third party relating to the Mobile App or your possession and use of the Mobile App, including, but not limited to: (a) product liability claims; (b) any claim that the Mobile App fails to conform to any applicable legal or regulatory requirement; and (c) claims arising under consumer protection or similar legislation; (iv) in the event of any third party claim that the Mobile App or your possession and use of that Mobile App infringes that third party’s intellectual property rights, we will be responsible for the investigation, defense, settlement and discharge of any such intellectual property infringement claim to the extent required by these Terms & Conditions; (v) the Mobile App Provider and its subsidiaries are third party beneficiaries of these Terms & Conditions as it relates to your license of the Mobile App, and that, upon your acceptance of these Terms & Conditions, the Mobile App Provider will have the right (and will be deemed to have accepted the right) to enforce these Terms & Conditions as related to your license of the Mobile App against you as a third party beneficiary thereof; and (vi) you must also comply with all applicable third party terms of service when using the Services.

""",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    const CustomText(
                      text: """3. ELIGIBILITY

We do not permit individuals under 18 years of age to become registered users of our Services. By using the Services, you represent and warrant that you are at least 18 years of age and have the right, authority and capacity to enter into these Terms & Conditions and to abide by the terms and conditions of these Terms & Conditions.


Due to the physiological sensitivity that occurs with pregnancy and our inability to provide collaborative care with physicians/other medical professionals, individuals who are pregnant will be unable to use our Services.


Individuals who are currently or have a goal to be at a BMI below 18.5 will be unable to use our Services. According to the Center for Disease Control (CDC), current medical standards indicate a healthy BMI range to be between 18.5-24.9, with a BMI falling below 18.5 to be considered underweight. Weight loss for underweight individuals is not recommended and should be supervised by a medical professional.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,

                    ),
                    CustomText(
                      text: """4. SUBSCRIPTIONS; BECOMING A PREMIUM SERVICE USER

Our Services consist of a free, limited version Mobile App (“Basic Service”) and premium products with differing functionality based on the subscription level (“Premium Service”). Premium Service typically requires a fee, which is either paid (i) by the user (“Personal Premium Service”) or (ii) by a third party on behalf of the user (“Business Premium Service”). You do not have to become a Premium Service user to use the Services. However, if you are not a Premium Service user, you may be precluded from using certain portions, components, content, features, or resources of our Services. We reserve the right to eliminate or modify any or all of the functionality of the Basic Service at any time without any prior notice to you.


Whether or not you use the Basic Service or the Premium Service, you are responsible for all charges and fees associated with connecting to and using the Website and/or Mobile App, including without limitation all telephone access lines (including mobile data and data roaming charges, when applicable), telephone and/or internet service provider fees, telephone and computer equipment, sales taxes and any other fees and charges necessary to access our Website and/or Mobile App.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """5. FEES, RENEWALS, AND CANCELLATIONS 

If you are a subscriber to our Premium Service, you further agree as follows:


a. Agreement to Pay.

(i) Personal Premium Service. If you are a Personal Premium Service User, you will be responsible for the fixed and periodic charges and fees (including prepayment plan fees for multiple periods or recurring monthly fees) you selected at the time of subscription. Applicable taxes, and other charges and fees incurred in order to access the Premium Services may also apply.


(ii) Business Premium Service. Business Premium Services are generally purchased by our third party commercial customers (“Business Customers”) for a specified period, and a Business Customer generally provides you with a unique activation code that allows you to access certain Premium Service features purchased by such Business Customer for a specified period. In such instance, your access to Premium Service has been paid for by our Business Customer, and you will be able to use Business Premium Service features until the expiration of a specified term agreed between Eat Well Tracker and such Business Customer.


b. Auto-Renewal. Unless your Premium Services have been paid for by one of our Business Customers, your Premium Service membership will automatically be extended for successive renewal periods of the same duration selected at the time of your purchase, at the then-current non-promotional subscription rate. Until you cancel, we will charge or debit your payment method at the beginning of your subscription. Your non-cancellation of the Premium Services or continued use of the paid subscription features of the Premium Service will reaffirm that we are authorized to charge you. If your credit or debit account has been closed or your payment method is otherwise invalid, your subscription may not renew and your subscription will be automatically downgraded to the Basic Service effective as of the end of your current billing cycle. The renewal charge will generally be the same as the prior period’s charge, unless we notify you in advance at the time of sign up or prior to the beginning of the renewal period as described above. If (i) you purchased a multiple-period prepayment plan or (ii) you were eligible for a promotional rate but are no long eligible for that rate, then your subscription will be offered to renew your subscription at our then-current non-promotional subscription rates at the start of the renewal period. If you wish to renew and we are currently offering promotional rates at such time, you must renew your subscription prior to the termination of your current plan. If you fail to renew your subscription for any Premium Services before its scheduled expiration date, then the then-current non-promotional subscription rate will apply.


c. Cancellation of Personal Premium Service Subscription. You can cancel your subscription for our Premium Services at any time by contacting Customer Support at support@EatWellTracker.com or at Eat Well Tracker, LLC., 3330 Cumberland Blvd Suite 200 Atlanta GA 30350  Attn: Still, Customer Support, or by such other means as we may provide from time to time. We will attempt to process all cancellation requests within 72 hours after we receive your request. We reserve the right to collect fees, surcharges, or costs incurred before your cancellation takes effect. If you terminate your paid subscription for Premium Service, your subscription will remain active until the end of your then-current subscription period.


d. Membership through Business Customers. For Business Premium Services users, the Business Customer paying for your Business Premium Service subscription controls such an account (which may be different from your personal account) and may terminate your access to it. You agree that we will not be liable to you or any third-party for any termination or cancellation of your access to, or use of, our Premium Services that were originally provided to you by such Business Customer. If your had Business Premium Service subscriptions paid through a Business Customer but you are no longer eligible to receive such benefit from the Business Customer, it is also possible that your Business Premium Service account will terminate with us, and you will have to sign up for a new account.


e. Modifications. We reserve the right to revise the terms of the fee charge, cancellation and refund policies, upon reasonable advance notice communicated to you through a posting on the Website and/or Mobile App or such other means as we may deem appropriate from time to time (including electronic mail or conventional mail). Any changes made will apply to all memberships created or renewed after the date such change was implemented.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """6. USER ACCOUNT AND SECURITY

In connection with your use of certain features of the Services, you will be required to complete a registration form. You represent and warrant that all user information you provide on the registration form or otherwise in connection with your use of the Services will be current, complete and accurate. As a registered user of the Services, you are entirely responsible for maintaining the confidentiality of your user account information. You may not use the account or user name of any other member at any time. You must notify us immediately in the event of any known or suspected unauthorized use of your user account, or any known or suspected breach of security, including loss, theft, or unauthorized disclosure of your or anyone else’s user account information.


You are also entirely responsible for any and all activities which occur under your user account. We will not be liable for any loss that you incur as a result of someone else using your account, either with or without your knowledge. You may also be held liable for any losses incurred by Eat Well Tracker, its affiliates, officers, directors, employees, consultants, agents and representatives due to someone else’s use of your account.


As a subscriber to our Premium Services, you further agree as follows:

a. Subscription Data. For purposes of your use of the Premium Service including identification and billing, you agree to provide us with true, accurate and complete information as required by the subscription or sign up process to the Premium Service (“Subscription Data”). We collect different data depending on whether you are a Personal Premium Service User or Business Premium Service User. Please refer to our Privacy Policy and HIPAA Notice for more detailed information on the types of information we collect. You agree to maintain and promptly update the Subscription Data and any other information you provide to us to keep it accurate. Without limiting any other provision of these Terms & Conditions, if you provide any information that is untrue, inaccurate, or incomplete, or we have reasonable grounds to suspect that such is the case, we reserve the right to suspend or terminate your user account or subscription and refuse any and all current or future use by you of our Services (or any portion thereof). You are obligated to check whether your Subscription Data is current and accurate, and, if not, to correct or update your Subscription Data.


b. One Account Per User. You agree not to register or subscribe for more than one account, create an account on behalf of someone else, or create a false or misleading identity on this Website. If your registration or subscription is revoked for any reason (other than in cases where you are switching over from Business Premium Services to Personal Premium Service and vice versa), you agree not to register or subscribe again with our Services using another user name or through any other means. If we have reason to suspect, in our sole discretion, that your account has previously been terminated, we reserve the right to terminate any new accounts you have registered without any notice to you, or to exercise any other remedies available to us under these Terms & Conditions or by law.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(

                      text: """7. CONSENT TO RECEIVE ELECTRONIC COMMUNICATIONS FROM EAT WELL TRACKER & BUSINESS CUSTOMERS

a. Legal Communications. We may send the following to you by email or posting them on the Website and/or the Mobile App: these Terms & Conditions, including legal disclosures; future changes to these Terms & Conditions, Privacy Policy, HIPAA Notice, and other notices, legal communications or disclosures and information related to the Services. Such communications are part of the Services which you cannot opt out of receiving.


b. Service Announcements. In using the Services, you may receive periodic electronic communications from Eat Well Tracker regarding the Services, such as new product offers and other information regarding the Website and/or the Mobile App, which are part of the Services and which you cannot opt out of receiving.


c. Promotional Communications. You may also receive periodic promotions and other offers or materials Eat Well Tracker believes might be of interest to you. You can opt-out of receiving these promotional messages at any time by (a) following the unsubscribe instructions contained in each message; or (b) changing the messaging preferences in your account.


d. Business Customer Communications. If you have a Business Premium Service account (e.g., your Premium Services were purchased by a Business Customer and were offered to you free of charge by such Business Customer), the Business Customer paying for your Business Premium Services may also send periodic electronic communications or post materials on our Mobile App, subject to their applicable terms and conditions and/or privacy policy.


e. Withdrawing Your Consent. If you later decide that you do not want to receive future Communications electronically, please send an email to support@EatWellTracker.com or a letter to Eat Well Tracker, Inc., Attention: Still, Customer Service, 3330 Cumberland Blvd Suite 200 Atlanta GA 30339. Your withdrawal of consent shall be effective within a reasonable time after we receive your withdrawal notice described above. Your withdrawal of consent will not affect the legal validity or enforceability of the Terms provided to, and electronically signed by, you prior to the effective date of your withdrawal. If you withdraw your consent to receive Communications electronically, we may terminate your account and/or access to the Service (or any part thereof).

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,

                    ),
                    CustomText(
                      text: """8. PUBLIC FORUM; INFORMATION PROVIDED BY MEMBERS

a. Definition. “Public Forum” is any area, site or feature offered as part of the Services (including, but not limited to, chat, message board, blog, groups, emails or instant messaging features) that enables you (a) to upload, submit, post, display, perform, distribute and/or view User Content, and/or (b) to communicate, share, or exchange User Content with other members. Except as otherwise provided in our Privacy Policy and HIPAA Notice, all Public Forum communications are public and not private communications. You are, and shall remain, solely responsible for the User Content that you upload, submit, post, transmit, communicate, share or exchange by means of any Public Forum and for the consequences of submitting or posting same.


b. Eat Well Tracker Group. As a subscriber to our Premium Services, you are automatically invited to join and participate in group discussions (“Eat Well Tracker Group”) with other Services users that may be designated as a Eat Well Tracker Group facilitator by Eat Well Tracker (such person or persons, collectively, the “Facilitators”) as well as a coach, who may be an employee or a contractor of Eat Well Tracker, personnel from an unaffiliated third party service provider or personnel from, or designated by, our Business Customer (such person, a “Coach”). Eat Well Tracker Group is a Public Forum, and by using the Eat Well Tracker Group, you may receive electronic communications, including group chat messages and/or private messages from Coaches, Facilitators and other Eat Well Tracker Group members who are members of the same Eat Well Tracker Group. Eat Well Tracker Group members can see your user id and public profile, but will not see your email address. If you do not wish to receive messages from other members, you should opt out of a Eat Well Tracker Group. Whether you transmit any user content via private messaging or group chat feature, you agree to abide by our community standards and conduct guidelines at all times. You further acknowledge that by providing you with the ability to distribute User Content in the discussion forums, we are acting as a passive conduit for such distribution and we are not undertaking any obligation or liability relating to any User Content or activity in any Public Forum, nor do we endorse any such User Content or activity. Although we reserve the right to monitor some, all, or no areas of the Services (including any discussion forum and Eat Well Tracker Group) for adherence to the community standards and conduct guidelines set forth above and to remove, without notice, any User Content for any reason, we have no obligation to review Content prior to the Content’s posting or to delete User Content that you may find objectionable or offensive. EAT WELL TRACKER DISCLAIMS ANY PERCEIVED, IMPLIED OR ACTUAL DUTY TO MONITOR PUBLIC FORUMS AND SPECIFICALLY DISCLAIMS ANY RESPONSIBILITY OR LIABILITY FOR INFORMATION PROVIDED THEREON.


c. Public Profile; Information Provided by Members. In order to join a Eat Well Tracker Group or access similar services that provide Public Forums or interactions with other members, you may be required to create public profiles, which may contain certain identifying information (such as age, profile photos, location, etc.). In addition, members have the option to post photographs, messages, videos and other information on their public profiles. Eat Well Tracker relies on its members to provide current and accurate information, and Eat Well Tracker does not, and cannot, investigate information contained in member public profiles. Accordingly, we must assume that information contained in each member public profile is current and accurate. EAT WELL TRACKER DOES NOT REPRESENT, WARRANT OR GUARANTEE THE CURRENCY OR ACCURACY OF PUBLIC PROFILE INFORMATION, AND HEREBY DISCLAIMS ALL RESPONSIBILITY AND LIABILITY FOR ANY INFORMATION PROVIDED BY MEMBERS BY MEANS OF PUBLIC PROFILES OR OTHERWISE IN CONNECTION WITH THEIR USE OF THE SERVICES.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """9. LIMITED LICENSE

Subject to your continued compliance with the Terms & Conditions, including without limitation the timely payment of all applicable fees, we grant you a non-exclusive, non-transferable, non-sublicensable, fully revocable, limited license to access and use our Services (whether through the Website or by downloading and installing the Mobile App, including any updates and bug fixes). Your use is limited for your personal, noncommercial use only.


The Services, or any portion thereof, may not be reproduced, duplicated, copied, modified, sold, resold, distributed, visited, or otherwise exploited for any commercial purpose without the express written consent of Eat Well Tracker. Furthermore, except for the limited rights granted in this Section, you will not (and will not encourage or assist any third party to): (i) modify, alter, tamper with, repair or otherwise create derivative works of the Services or any software or technology included in or used or distributed by Eat Well Tracker to provide the Services; or (ii) reverse engineer, disassemble or decompile the Services, or attempt to discover or recreate the source code for the Services.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(

                      text: """10. RESTRICTIONS ON USE OF CONTENT

You acknowledge that our Services contain content, information, software, photos, video, text, graphics, music, sounds, questions, creative suggestions, messages, comments, feedback, ideas, recipes, notes, drawings, articles and other materials, including nutritional information contributed to the Food Database (hereinafter defined) (collectively, “Content”) that are protected by copyrights, patents, trademarks, trade secrets and/or other proprietary rights, and that these rights are valid and protected in all forms, media and technologies existing now or hereafter developed. All Content is copyrighted under the United States copyright laws (and, if applicable, similar foreign laws), and we own a copyright in the selection, coordination, arrangement and enhancement of such Content. All trademarks appearing on the Services are trademarks of their respective owners. The Eat Well Tracker Marks (hereinafter defined) are tradename and the registered trademark and service mark of Eat Well Tracker, Inc.


Our commercial partners, suppliers, advertisers, sponsors, licensors, contractors and other third parties may also have additional proprietary rights in the Content which they make available on our Services. You may not modify, publish, transmit, distribute, perform, participate in the transfer or sale, create derivative works of, or in any way exploit, any of the Content, in whole or in part. When Content is downloaded to your computer, phone, tablet or any other mobile device, you do not obtain any ownership interest in such Content. Modification of the Content or use of the Content for any other purpose, including, but not limited to, use of any Content in printed form or on any other applications or networked computer environment is strictly prohibited unless you receive our prior written consent.


We may at any time suspend your use of the Services and/or remove or disable any Content as to which we reasonably and in good faith believe is in violation of any of these Terms & Conditions. We will provide you with notice of any such suspension or disablement before its implementation unless such suspension or disablement is necessary to comply with legal process, regulation, order or prevent imminent harm to the Services or any third party, in which case we will notify you to the extent allowed by applicable law of such suspension or disablement as soon as reasonably practicable thereafter.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """11. FOOD DATABASE AND DISCLAIMER

As part of the Services, Eat Well Tracker maintains a food database that contains a combination of nutritional information entered directly by Eat Well Tracker and nutritional information entered by Eat Well Tracker’s Services users (“Food Database”). Any Services user can contribute nutritional information to the Food Database. Please be advised that nutritional information found in the Food Database has not been reviewed by persons with the expertise required to provide you with complete, accurate, or reliable information.


EAT WELL TRACKER DOES NOT (I) GUARANTEE THE ACCURACY, COMPLETENESS, OR USEFULNESS OF ANY NUTRITIONAL INFORMATION IN THE FOOD DATABASE; OR (II) ADOPT, ENDORSE OR ACCEPT RESPONSIBILITY FOR THE ACCURACY OR RELIABILITY OF ANY SUCH NUTRITIONAL INFORMATION. UNDER NO CIRCUMSTANCES WILL EAT WELL TRACKER BE RESPONSIBLE FOR ANY LOSS OR DAMAGE RESULTING FROM YOUR RELIANCE ON NUTRITIONAL INFORMATION.


You are solely responsible for ensuring that any nutritional information in the Food Database is accurate, complete and useful. Nutritional information in the Food Database may not be reproduced, duplicated, copied, modified, sold, resold, distributed, visited, or otherwise exploited for any commercial purpose without the express written consent of Eat Well Tracker.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,

                    ),
                    CustomText(
                      text: """12. USER CONTENT

a. Definition. “User Content” is any content, materials or information (including without limitation, any text, information, graphics, messages, photos, images, nutritional information contributed to the our food database and works of authorship kind), data, questions, comments, suggestions or other content, including personally identifiable information that you upload, send, email, display, perform, distribute, post or otherwise transmit to us, at our request or on your own, on, or through the Services (such as message boards, recipe logging), whether in connection with your use of the Services or through the use of any Third Party Websites or Third Party Services or otherwise, and whether publicly posted or privately transmitted.


b. Agreement. You represent and warrant that, when using the Services, you will obey the law and respect the intellectual property rights of others. Your use of the Services is at all times governed by and subject to laws regarding copyright ownership and use of intellectual property generally. You agree not to upload, post, transmit, display, perform or distribute any content, information or other materials in violation of any third party’s copyrights, trademarks, or other intellectual property or proprietary rights, or rights or publicity or privacy, or in violation of any applicable law or regulation.


YOU SHALL BE SOLELY RESPONSIBLE FOR ANY VIOLATIONS OF ANY LAWS AND FOR ANY INFRINGEMENTS OF THIRD-PARTY RIGHTS CAUSED BY YOUR USE OF THE SERVICES. YOUR BEAR THE SOLE BURDEN OF PROVING THAT CONTENT, INFORMATION OR OTHER MATERIALS DO NOT VIOLATE ANY LAWS OR THIRD-PARTY RIGHTS.


c. Grant of License. You hereby grant Eat Well Tracker, its directors, officers, employees, agents, affiliates, representatives, service providers, partners, sublicensees, successors and assigns (collectively, the “Eat Well Tracker Parties”) a royalty-free, perpetual, irrevocable, sublicensable, assignable, non-exclusive right (including any moral rights) and license (as well as consent) to use, license, reproduce, modify, adapt, publish, translate, transmit, edit, reformat, create derivative works from, distribute, derive revenue or other remuneration from, communicate to the public, perform, display and otherwise use any User Content (in whole or in part and with or without the use of your name) worldwide and/or to incorporate the User Content in other works in any form, media, or technology now known or later developed, for the full term of any copyrights, trademarks and other intellectual and proprietary rights (collectively, the “Rights”) that may exist in such User Content.


You hereby represent and warrant that you own all rights, title and interest in and to User Content or are otherwise authorized to grant the rights provided to the Eat Well Tracker Parties under this section. You also warrant that, to the extent you are not the exclusive holder of all Rights in a User Content, any third party holder of any Rights, including moral rights in such User Content, has completely and effectively waived all such rights and validly and irrevocably granted to you the right to grant the license stated above. You further acknowledge that we and our successors and assigns shall be entitled to unrestricted use of the User Content for any purpose whatsoever, commercial or otherwise, without compensation to the provider of the User Content. You also permit any user to access, display, view, store and reproduce any User Content that you have made available in any Public Forum (including a Eat Well Tracker Group) for personal use. Subject to the foregoing, the owner of a User Content placed on the Services retains any and all Rights that may exist in such User Content. Except as provided in our Privacy Policy and HIPAA Notice, none of the User Content shall be subject to any obligation of confidence on our part, and you agree to waive, and hereby waive, any claims arising from or relating to the exercise by the Eat Well Tracker Parties of the rights granted under this section. You will not be compensated for any exercise of the license granted under this section.


We are not responsible for maintaining a copy of any material we remove from our Services, and we are not liable for any loss you incur in the event that Content you post or transmit to our Services is removed.


Eat Well Tracker reserves the right to (i) remove, suspend, edit or modify any User Content in its sole discretion at any time, without notice to you and for any reason (including, but not limited to, upon receipt of claims or allegations from third parties or authorities relating to such User Content or if Eat Well Tracker is concerned that you may have violated these Terms & Conditions), or for no reason at all and (ii) to remove, suspend or block any User Content. Eat Well Tracker also reserves the right to access, read, preserve, and disclose any information as Eat Well Tracker reasonably believes is necessary to (i) satisfy any applicable law, regulation, legal process or governmental request, (ii) enforce these Terms & Conditions, including investigation of potential violations hereof, (iii) detect, prevent, or otherwise address fraud, security or technical issues, (iv) respond to user support requests, or (v) protect the rights, property or safety of Eat Well Tracker, its users and the public.


You acknowledge that all User Content are the sole responsibility of the person who made such User Content. This means that you are entirely responsible for all User Content that you post, email or otherwise transmit to the Website, the Mobile and the Services. We do not control the User Content posted, emailed or otherwise transmitted on our Services by others and, as such, we do not guarantee the accuracy, integrity or quality of such User Content. Although we have adopted community standards and conduct guidelines for the users of the Services (as described below), you understand that by using the Services, you may be exposed to User Content that are offensive or objectionable.


EAT WELL TRACKER DISCLAIMS ANY PERCEIVED, IMPLIED OR ACTUAL DUTY TO MONITOR THE USER CONTENT, AND SPECIFICALLY DISCLAIMS ANY RESPONSIBILITY OR LIABILITY FOR INFORMATION PROVIDED HEREIN. UNDER NO CIRCUMSTANCES WILL WE BE LIABLE IN ANY WAY FOR ANY USER CONTENT (OTHER THAN FOR CONTENT DEVELOPED BY US), INCLUDING, BUT NOT LIMITED TO, FOR ANY ERRORS OR OMISSIONS IN ANY USER CONTENT, OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY USER CONTENT POSTED, EMAILED OR OTHERWISE TRANSMITTED TO OR THROUGH THE SERVICES.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """13. THIRD-PARTY WEBSITE CONTENT

Certain Contents provided in the Website and/or Mobile App include links to websites of third parties (“Third-Party Websites”), some of whom may have established relationships with Eat Well Tracker and some of whom may not. We do not have control over the content and performance of Third-Party Websites.


EAT WELL TRACKER HAS NOT REVIEWED, AND CANNOT REVIEW OR CONTROL, ALL OF THE MATERIAL, INCLUDING COMPUTER SOFTWARE OR OTHER GOODS OR SERVICES, MADE AVAILABLE ON OR THROUGH THIRD-PARTY WEBSITES AND DOES NOT ENDORSE (AND IS NOT RESPONSIBLE OR LIABLE FOR) ANY CONTENT, ADVERTISING, PRODUCTS, OR OTHER MATERIALS ON OR AVAILABLE FROM SUCH THIRD PARTY WEBSITES. ACCORDINGLY, EAT WELL TRACKER DOES NOT REPRESENT, WARRANT OR ENDORSE ANY THIRD-PARTY WEBSITE, OR THE ACCURACY, CURRENCY, CONTENT, FITNESS, LAWFULNESS OR QUALITY OF THE INFORMATION MATERIAL, GOODS OR SERVICES AVAILABLE THROUGH THIRD-PARTY WEBSITES. EAT WELL TRACKER DISCLAIMS, AND YOU AGREE TO ASSUME, ALL RESPONSIBILITY AND LIABILITY FOR ANY DAMAGES OR OTHER HARM, WHETHER TO YOU OR TO THIRD PARTIES, RESULTING FROM YOUR USE OF OR RELIANCE ON, ANY CONTENT, ADVERTISEMENTS, PRODUCTS OR OTHER RESOURCES AVAILABLE ON ANY THIRD-PARTY WEBSITES (REGARDLESS OF WHETHER WE DIRECTLY OR INDIRECTLY LINK TO SUCH CONTENT, ADVERTISEMENTS, PRODUCTS OR OTHER RESOURCES).


YOU AGREE THAT, WHEN LINKING TO OR OTHERWISE ACCESSING OR USING A THIRD-PARTY WEBSITE, YOU ARE RESPONSIBLE FOR: (I) TAKING PRECAUTIONS AS NECESSARY TO PROTECT YOU AND YOUR COMPUTER SYSTEMS FROM VIRUSES, WORMS, TROJAN HORSES, MALICIOUS CODE AND OTHER HARMFUL OR DESTRUCTIVE CONTENT; (II) ANY DOWNLOADING, USE OR PURCHASE OF MATERIAL THAT IS OBSCENE, INDECENT, OFFENSIVE, OR OTHERWISE OBJECTIONABLE OR UNLAWFUL, OR THAT CONTAINS TECHNICAL INACCURACIES, TYPOGRAPHICAL MISTAKES AND OTHER ERRORS; (III) ANY DOWNLOADING, USE OR PURCHASE OF MATERIAL THAT VIOLATES THE PRIVACY OR PUBLICITY RIGHTS, OR INFRINGES THE INTELLECTUAL PROPERTY AND OTHER PROPRIETARY RIGHTS OF THIRD PARTIES, OR THAT IS SUBJECT TO ADDITIONAL TERMS AND CONDITIONS, STATED OR UNSTATED; (IV) ALL FINANCIAL CHARGES OR OTHER LIABILITIES TO THIRD PARTIES RESULTING FROM TRANSACTIONS OR OTHER ACTIVITIES; AND (V) READING AND UNDERSTANDING ANY TERMS OF USE OR PRIVACY POLICIES THAT APPLY TO THOSE THIRD-PARTY WEBSITES.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """14. COMMUNITY STANDARDS AND CONDUCT GUIDELINES

You agree that you will not (and/or will not use the Website, the Mobile App and/or any part of our Services to):

a. Upload, post, email or otherwise transmit any User Content or other materials that:


(i) are unlawful, harmful, threatening, abusive, harassing, inflammatory, tortious, defamatory, vulgar, libelous, slanderous, discriminatory, invasive of another’s privacy, hateful, or racially, ethnically or otherwise objectionable (in our sole discretion);

(ii) contain adult content, including obscene, pornographic, and/or sexual terms, descriptions and/or images, nudity, profanity or graphic violence;

(iii) incite or encourage criminal or terrorist activities or physical harm against another;

(iv) exploit political agendas or “hot button” issues for commercial use; or that contain hate speech based upon the race, sex, national original, religious affiliation, marital status, sexual orientation, gender identify, or language of an individual or group;

(v) are not your own, or that you do not have a right to upload, post, email or otherwise transmit under any law or under contractual or fiduciary relationships (such as insider information, proprietary and confidential information learned or disclosed as part of employment relationships or under nondisclosure agreements);

(vi) infringe upon any patent, trademark, trade secret, copyright, right of privacy or publicity or other proprietary rights of any party or that are deceptive, misleading or fraudulent or that may otherwise be unlawful or give rise to civil or criminal liability;

(vii) are unauthorized advertising, promotional materials, “junk mail,” “spam,” “phishing,” “chain letters,” “pyramid schemes,” or any other form of solicitation, opinions or notices, commercial or otherwise;

(viii) contain software viruses, spyware, adware, worms, or any other computer malware or malicious code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment;

b. Harm minors in any way, or solicit or otherwise attempt to gain any information from a minor;


c. Advertise or otherwise solicit funds or constitute a solicitation for goods or services;


d. Impersonate any person or entity, including, but not limited to any user of the Services, a director, officer, employee, shareholder, agent or representative of Eat Well Tracker, our Business Customers or any other person or entity, or falsely state or otherwise misrepresent your affiliation with Eat Well Tracker. our Business Customers or any other person or entity;


e. Provide false, misleading or inaccurate information to Eat Well Tracker or any other member;


f. Create more than one unique public profile or register for more than one account except as specifically permitted in these Terms & Services, create an account on behalf of someone else, or create a false or misleading identity on the Services;


g. Forge headers or otherwise manipulate identifiers in order to disguise the origin of any Content or other materials transmitted to or through the Services;


h. Attempt to probe, scan or test the vulnerability of the Services or any associated system or network, or breach security or authentication measures without proper authorization;


i. Use or affect the Services in any manner that could damage, disable, overburden or impair the Services or its functionality, or disrupt the normal flow of dialogue (including, without limitation, “flooding,” “mail bombing,” or “crashing”), or otherwise act in a manner that negatively affects or otherwise diminishes the quality of another user’s experience of the Services;


j. Interfere with or disrupt the Services or servers or networks connected to the Services, or disobey any requirements, procedures, policies or regulations of networks connected to the Services;


k. Intentionally or unintentionally violate any applicable local, state, national or international law, including, but not limited to, any regulations having the force of law;


l. “Stalk” or otherwise harass another user or employee of the Services;


m. Solicit, collect or post personal data or attempt to solicit, collect or post personal data about other users of the Services, including usernames or passwords;


n. Access or attempt to access another user’s account without his or her consent;


o. Reverse engineer, disassemble or decompile the Mobile App, or attempt to discover or recreate the source code for the Mobile App or any portion of the Services; or


p. Assign, transfer or sublicense your rights as a registered user of the Services.


Your privilege to use the Services (including your ability to contribute to discussions on the Public Forum or communicate with Coaches and/or other users in a Eat Well Tracker Group) depends on your compliance with the community standards and conduct guidelines set forth above. We may revoke your privileges to use all or a portion of the Services and/or take any other appropriate measures to enforce these community standards and conduct guidelines if violations are brought to our attention. Further, if you fail to adhere to our community standards and conduct guidelines, or any part of these Terms & Conditions, we may terminate, in our sole discretion, your use of, or participation in, any Public Forum or the Services. Any violation of this section may subject you to civil and/or criminal liability.


YOU AGREE AND UNDERSTAND THAT YOU MAY BE HELD LEGALLY RESPONSIBLE FOR DAMAGES SUFFERED BY OTHER MEMBERS OR THIRD PARTIES AS THE RESULT OF YOUR REMARKS, INFORMATION, FEEDBACK OR OTHER CONTENT POSTED OR MADE AVAILABLE ON THE SERVICES (INCLUDING ANY PUBLIC FORUM) THAT IS DEEMED DEFAMATORY OR OTHERWISE LEGALLY ACTIONABLE. UNDER THE FEDERAL COMMUNICATIONS DECENCY ACT OF 1996, EAT WELL TRACKER IS NOT LEGALLY RESPONSIBLE, NOR CAN IT BE HELD LIABLE FOR DAMAGES OF ANY KIND, ARISING OUT OF OR IN CONNECTION TO ANY DEFAMATORY OR OTHERWISE LEGALLY ACTIONABLE REMARKS, INFORMATION, FEEDBACK OR OTHER CONTENT POSTED OR MADE AVAILABLE ON THE SERVICES.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """15. HEALTH AND MEDICAL SERVICE DISCLAIMER

WE DO NOT PROVIDE PROFESSIONAL MEDICAL SERVICES OR ADVICE. THE SERVICES PROVIDED BY THE WEBSITE AND/OR MOBILE APP DO NOT CONTAIN OR CONSTITUTE, AND SHOULD NOT BE INTERPRETED AS, MEDICAL ADVICE OR OPINION. NO DOCTOR-PATIENT RELATIONSHIP IS CREATED. USE OF THE SERVICES IS NOT FOR MEDICAL EMERGENCIES. IF YOU THINK YOU HAVE A MEDICAL EMERGENCY, CALL 911.


a. No Doctor-Patient Relationship. Any and all services provided by, in and/or through the Services are for informational purposes only. Eat Well Tracker is not a medical professional, and Eat Well Tracker does not provide medical services or render medical advice. Nothing contained in the Services should be construed as such advice or diagnosis. The information and reports generated by us should not be interpreted as a substitute for physician consultation, evaluation, or treatment, and the information made available on or through the Services should not be relied upon when making medical decisions, or to diagnose or treat a medical or health condition. YOUR USE OF THE SERVICES DOES NOT CREATE A DOCTOR-PATIENT RELATIONSHIP BETWEEN YOU AND ANY OF THE EAT WELL TRACKER PARTIES (INCLUDING, WITHOUT LIMITATION, COACHES) OR ANY OF EAT WELL TRACKER SERVICE USERS).


You are urged and advised to seek the advice of a physician or a medical professional with any questions you may have regarding your health before beginning any weight loss effort regimen, physical activities or any other plans that may be referenced, discussed or offered under the Services. If you are being treated for an illness, taking prescription medication or following a therapeutic diet to treat a disease, it is especially urged to consult with your physician before using the Services. You represent to us (which representation shall be deemed to be made each time you use the Services), that you are not using the Services or participating in any of the activities offered by the Services for purpose of seeking medical attention. You further agree that, before using the services, you shall consult your physician, particularly if you are at risk for problems resulting from exercise or changes in your diet. If any information you receive or obtain from using the Services that is inconsistent with the medical advice from your physician, you should follow the advice of your physician.


b. Virtual Coaching Service Disclaimer. If you are a Premium Service user, you have access to personal coaching services (“Virtual Coaching Service”). If you have access to our Virtual Coaching Service, you will be able to interact with a Coach. A Coach will assist his/her users in developing skills to help them achieve their health related goals. Eat Well Tracker may, in its sole discretion, engage or replace any Coach with another without notice to the Virtual Coaching Service users.


The services provided by our Virtual Coaching Service are not medical, mental health or any other type of health service. Virtual Coaching Service is not psychotherapy or mental health counseling. No diagnosis or treatment of, or advice regarding, any medical or mental health condition or illness will be offered. The Virtual Coaching Service cannot substitute for, and is not an alternative to, medical, psychiatric, psychological, psychotherapy or other healthcare diagnosis and treatment when a medical or mental health condition or illness is present. You are advised to seek diagnosis, treatment and advice regarding medical or mental conditions or illnesses from physicians practicing medicine, psychotherapists, psychologists and other licensed healthcare and mental health professionals.


Eat Well Tracker Groups led by a Coach(es) are designed to provide individuals with education, information and personal support from peers and the group leader regarding your health-related issues and goals. For example, a Business Customer, a healthcare provider, may contract Eat Well Tracker to provide Business Premium Services and ask you to use our Services to track your medical treatments and progress. In such case, your Coach may provide general information about psychological and emotional issues related to health conditions, medical treatments, success stories, and health-related goals in order to help you adhere to the specific regimen prescribed by your physician. However, Coaches are not allowed to use the Virtual Coaching Service to engage in rendering any type of psychological or healthcare advice for any individual or for his or her particular situation. Under no circumstances will any of your interactions with any Coach or any User of the Services be deemed or construed to create a physician-patient relationship or a fiduciary duty of any kind whatsoever. IF EAT WELL TRACKER BECOMES AWARE OF OR SUSPECTS ANY MEDICAL OR MENTAL CONDITIONS OR ILLNESS, EAT WELL TRACKER MAY, AT ITS SOLE DISCRETION, TERMINATE ALL OR ANY PORTION OF THE SERVICES.


YOU ARE SOLELY RESPONSIBLE FOR YOUR INTERACTIONS WITH COACHES AND/OR OTHER MEMBERS WHEN USING THE SERVICES.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """16. RISK ASSUMPTION; YOUR INTERACTIONS WITH OTHERS ON THE WEBSITES AND/OR MOBILE APPS

EAT WELL TRACKER EXPRESSLY DISCLAIMS ANY AND ALL LIABILITY THAT MAY ARISE FROM OR IN CONNECTION WITH YOUR USE OF THE SERVICES AND PARTICIPATION IN ANY OTHER ACTIVITIES OFFERED IN THE SERVICES, INCLUDING, WITHOUT LIMITATION, YOUR PARTICIPATION IN ANY EAT WELL TRACKER GROUP OR YOUR INTERACTIONS WITH ANY FACILITATOR OR COACHES. YOU KNOWINGLY AND FREELY ASSUME ALL RISK WHEN USING THE SERVICES.


YOU ARE SOLELY RESPONSIBLE FOR YOUR INTERACTIONS WITH OTHER MEMBERS. YOU ACKNOWLEDGE AND UNDERSTAND THAT EAT WELL TRACKER IS NOT OBLIGATED IN ANY WAY TO (A) SCREEN ITS MEMBERS, (B) INQUIRE INTO THE BACKGROUNDS OF ITS MEMBERS, OR (C) REVIEW OR VERIFY THE STATEMENTS OF ITS MEMBERS, INCLUDING WITHOUT LIMITATION INFORMATION OR REPRESENTATIONS CONTAINED IN PUBLIC PROFILES. YOU HEREBY AGREE TO EXERCISE REASONABLE PRECAUTION IN ALL INTERACTIONS WITH OTHER MEMBERS, PARTICULARLY IF YOU DECIDE TO MEET ANOTHER MEMBER IN PERSON. EAT WELL TRACKER DOES NOT REPRESENT, WARRANT, ENDORSE OR GUARANTEE THE CONDUCT OF ITS MEMBERS OR THEIR COMPATIBILITY WITH YOU.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """17. DISCLAIMERS OF WARRANTIES

EAT WELL TRACKER, ON BEHALF OF ITSELF AND ITS AFFILIATES AND ANY OF ITS OR THEIR RESPECTIVE THIRD-PARTY SERVICE PROVIDERS, LICENSORS AND SUPPLIERS, HEREBY DISCLAIMS ALL WARRANTIES. THE PRODUCTS, OFFERINGS, CONTENT AND MATERIALS PROVIDED IN THE SERVICES ARE PROVIDED “AS IS” AND WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED. TO THE FULLEST EXTENT PERMITTED BY LAW, EAT WELL TRACKER, ON BEHALF OF ITSELF, AND ITS AFFILIATES AND ANY OF ITS OR THEIR RESPECTIVE THIRD-PARTY SERVICE PROVIDERS, LICENSORS AND SUPPLIERS, DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, TITLE, COMPATIBILITY, SECURITY, ACCURACY OR NON-INFRINGEMENT. NEITHER EAT WELL TRACKER, ANY OF ITS AFFILIATES, NOR ANY OF ITS OR THEIR RESPECTIVE LICENSORS, LICENSEES, SERVICE PROVIDERS OR SUPPLIERS WARRANT THAT THE APPLICATIONS OR ANY FUNCTION CONTAINED IN THE APPLICATIONS WILL BE UNINTERRUPTED OR ERROR-FREE, THAT DEFECTS WILL BE CORRECTED, OR THAT THE APPLICATIONS OR THE SERVERS THAT MAKE THE APPLICATIONS AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS.


ANY PRODUCT, OFFERING, CONTENT AND MATERIAL DOWNLOADED OR OTHERWISE OBTAINED THROUGH THE USE OF THE SERVICES IS DONE AT YOUR SOLE RISK AND YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR DEVICES OR LOSS OF DATA THAT RESULTS FROM THE DOWNLOAD OF ANY SUCH PRODUCT, OFFERING, CONTENT OR MATERIAL.


NEITHER EAT WELL TRACKER, ANY OF OUR AFFILIATES, NOR ANY OF OUR OR THEIR RESPECTIVE LICENSORS, LICENSEES, BUSINESS CUSTOMERS, SERVICE PROVIDERS OR SUPPLIERS WARRANT OR MAKE ANY REPRESENTATIONS REGARDING THE USE OR THE RESULTS OF THE USE OF THE PRODUCTS, OFFERINGS, CONTENT AND MATERIALS IN THE SERVICES IN TERMS OF THEIR CORRECTNESS, ACCURACY, RELIABILITY, OR OTHERWISE.


NO ADVICE OR INFORMATION, OBTAINED BY YOU FROM OUR PERSONNEL OR THROUGH THE SERVICES SHALL CREATE ANY WARRANTY NOT EXPRESSLY PROVIDED FOR IN THESE TERMS & CONDITIONS.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(

                      text: """18. THIRD-PARTY PRODUCTS, SERVICES AND DATA COLLECTION

Certain features, aspects, software products and services offered through the Services are provided, in whole or in part, by third parties (“Third-Party Services” as provided by “Third-Party Service Providers”). In order to use Third-Party Services, you may be required to enter into additional terms and conditions with Third-Party Service Providers. Our Terms & Conditions apply only to the Services, and not to the apps of any other person or entity, and your right to use such Third Party Software as part of the Services is subject to and governed by the terms and conditions of the third party license applicable to such Third-Party Services. You acknowledge and agree that we are not responsible for the availability of such external sites or resources, and do not endorse (and are not responsible or liable for) any content, advertising, products or other materials on or available from such apps or resources. In the event of a conflict between the terms of these Terms & Conditions and the terms of such third party licenses, the terms of the third party licenses shall control with regard to your use of the relevant Third Party Service.


You further acknowledge and agree that a Third-Party Service Provider may collect and use certain information about you, which may include your personal information and (“Protected Health Information”). Any exchange of data, including Protected Health Information, or other interaction between you and a provider of a Third Party Services is solely between you and Third-Party Service Provider. Prior to providing information to any Third-Party Service Provider, you should review their privacy policy. If you do not understand or do not agree to the terms of a Third-Party Service Provider’s privacy policy, you should not use the related third-party services.


EAT WELL TRACKER DISCLAIMS, AND YOU AGREE TO ASSUME, ALL RESPONSIBILITY AND LIABILITY FOR ANY DAMAGES OR OTHER HARM, WHETHER TO YOU OR TO THIRD PARTIES, RESULTING FROM (I) YOUR USE OF OR RELIANCE ON, ANY CONTENT, ADVERTISEMENTS, PRODUCTS OR OTHER RESOURCES AVAILABLE ON ANY SUCH SERVICES OR RESOURCES (REGARDLESS OF WHETHER WE DIRECTLY OR INDIRECTLY LINK TO SUCH CONTENT, ADVERTISEMENTS, PRODUCTS OR OTHER RESOURCES) OR (II) YOUR INFORMATION COLLECTED OR USED BY THIRD-PARTY SERVICE PROVIDERS.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """19. LIMITATION OF LIABILITY

YOU EXPRESSLY UNDERSTAND AND AGREE THAT IN NO EVENT SHALL EAT WELL TRACKER, ITS AFFILIATES OR ANY OF ITS OR THEIR RESPECTIVE THIRD-PARTY SERVICE PROVIDERS, LICENSORS AND SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, EXEMPLARY OR PUNITIVE DAMAGES, OR ANY OTHER DAMAGES WHATSOEVER, INCLUDING BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA OR OTHER INTANGIBLE LOSSES (EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), ARISING OUT OF, OR RESULTING FROM, (A) THE USE OR THE INABILITY TO USE THE SERVICES; (B) THE USE OF ANY CONTENT OR OTHER MATERIAL ON THE WEBSITE, OUR APPLICATIONS OR APPLICATIONS LINKED TO OUR APPLICATIONS, (C) THE COST OF PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES RESULTING FROM ANY GOODS, DATA, INFORMATION OR SERVICES PURCHASED OR OBTAINED OR MESSAGES RECEIVED OR TRANSACTIONS ENTERED INTO THROUGH OR FROM THE SERVICES; (D) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (E) STATEMENTS OR CONDUCT OF ANY THIRD PARTY ON OUR SERVICES; OR (F) ANY OTHER MATTER RELATING TO THE SERVICES.


YOU, ON BEHALF OF YOURSELF, YOUR PERSONAL REPRESENTATIVES AND YOUR HEIRS, HEREBY VOLUNTARILY AGREE TO RELEASE, WAIVE, DISCHARGE, HOLD HARMLESS, DEFEND AND INDEMNIFY EAT WELL TRACKER, ITS AFFILIATES AND ANY OF EAT WELL TRACKER’S AND ITS AFFILIATES’ OFFICERS, DIRECTORS, SHAREHOLDERS, EMPLOYEES, AGENTS, AFFILIATES, REPRESENTATIVES, SUBLICENSEES, SUCCESSORS AND ASSIGNS FROM ANY AND ALL CLAIMS, ACTIONS OR LOSSES FOR BODILY INJURY, PROPERTY DAMAGE, WRONGFUL DEATH, EMOTIONAL DISTRESS, LOSS OF SERVICES OR OTHER DAMAGES OR HARM, WHETHER TO YOU OR TO THIRD PARTIES, WHICH MAY RESULT FROM YOUR USE OF THE SERVICES.


YOU UNDERSTAND AND AGREE THAT THE CANCELLATION OR TERMINATION OF YOUR SUBSCRIPTION IS YOUR SOLE RIGHT AND REMEDY WITH RESPECT TO ANY DISPUTE WITH US INCLUDING, WITHOUT LIMITATION, ANY DISPUTE RELATED TO, OR ARISING OUT OF: (I) THESE TERMS & CONDITIONS OR OUR ENFORCEMENT OR APPLICATION THEREOF; (II) ANY PRACTICE OR POLICY OF EAT WELL TRACKER INCLUDING THESE TERMS & CONDITIONS AND OUR PRIVACY POLICY, OR OUR ENFORCEMENT OR APPLICATION OF THESE POLICIES; (III) THE CONTENT AVAILABLE THROUGH THE WEBSITE AND/OR APPLICATIONS OR ANY CHANGE IN CONTENT PROVIDED THROUGH THE WEBSITE AND/OR APPLICATIONS THROUGH THE SERVICES; (IV) YOUR ABILITY TO ACCESS AND/OR USE OUR WEBSITE AND/OR APPLICATIONS; OR (V) THE AMOUNT OR TYPES OF OUR FEES OR CHARGES, SURCHARGES, APPLICABLE TAXES, OR BILLING METHODS, OR ANY CHANGE TO OUR FEES OR CHARGES, APPLICABLE TAXES, OR BILLING METHODS.


THE MAXIMUM LIABILITY OF EAT WELL TRACKER AND ITS AFFILIATES AND ITS OR THEIR RESPECTIVE THIRD-PARTY SERVICE PROVIDERS, LICENSORS AND SUPPLIERS TO YOU UNDER ALL CIRCUMSTANCES FOR ALL DAMAGES, LOSSES, AND CAUSES OF ACTION (WHETHER IN CONTRACT, TORT (INCLUDING, BUT NOT LIMITED TO, NEGLIGENCE), OR OTHERWISE) SHALL NOT EXCEED THE AMOUNT PAID BY YOU, IF ANY, FOR ACCESSING OUR SERVICES. IF ANY PORTION OF THIS LIMITATION OF LIABILITY IS FOUND TO BE INVALID, LIABILITY IS LIMITED TO THE FULLEST EXTENT PERMITTED BY LAW. YOU AGREE THAT THIS LIMITATION OF LIABILITY REPRESENTS A REASONABLE ALLOCATION OF RISK AND IS A FUNDAMENTAL ELEMENT OF THE BASIS OF THE BARGAIN BETWEEN EAT WELL TRACKER AND YOU. THE SERVICES WOULD NOT BE PROVIDED WITHOUT SUCH LIMITATIONS.


ANY CAUSE OF ACTION BY YOU ARISING OUT OF OR RELATING TO THE SERVICES, OR THESE TERMS & CONDITIONS MUST BE INSTITUTED WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION AROSE OR BE FOREVER WAIVED AND BARRED. ALL ACTIONS SHALL BE SUBJECT TO THE LIMITATIONS SET FORTH IN THESE TERMS & CONDITIONS.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(

                      text: """20. INTELLECTUAL PROPERTY

a. Software. You acknowledge and agree that the Services and all intellectual property rights associated therewith are, and shall remain, the property of Eat Well Tracker (and, where applicable, its licensors). Furthermore, you acknowledge and agree that the source and object code of the Website and/or Mobile App and the format, directories, queries, algorithms, structure and organization of the Website and/or Mobile App are the intellectual property and proprietary and confidential information of Eat Well Tracker and its affiliates, licensors and suppliers. Except as expressly stated in these Terms & Conditions, you are not granted any intellectual property rights in or to the Services by implication, estoppel or other legal theory, and all rights in and to the Services not expressly granted in these Terms & Conditions are hereby reserved and retained by Eat Well Tracker.


b. Trademarks. Eat Well Tracker, Eat Well Tracker.com, Eat Well Tracker Health and the Eat Well Tracker logo (collectively, the “Eat Well Tracker Marks”) are trademarks or registered trademarks of Eat Well Tracker, Inc. Other trademarks, service marks, graphics, logos and domain names appearing on the Website, Mobile App or in other Content provided to you may be the trademarks of third-parties. Neither your use of the Services, nor these Terms & Conditions, grant you any right, title or interest in or to, or any license to reproduce or otherwise use, the Eat Well Tracker Marks or any third-party trademarks, service marks, graphics, logos or domain names. You agree that any goodwill in the Eat Well Tracker Marks generated as a result of your use of the Services will inure to the benefit of Eat Well Tracker, Inc., and you agree to assign, and hereby do assign, all such goodwill to Eat Well Tracker, Inc. You shall not at any time, nor shall you assist others to, challenge Eat Well Tracker’s right, title, or interest in or to, or the validity of, the Eat Well Tracker Marks.


c. Copyrighted Materials; Copyright Notice. All content and other materials available through the Services, including without limitation the Eat Well Tracker logo, design, text, graphics, and other files, and the selection, arrangement and organization thereof, are either owned by Eat Well Tracker or are the property of Eat Well Tracker’s licensors and suppliers. Except as explicitly provided, neither your use of the Services nor these Terms & Conditions grant you any right, title or interest in or to any such content or materials.


d. Copyright Complaints. We respect the intellectual property of others, and we ask our users to do the same. We may, in appropriate circumstances and in our discretion, terminate the rights of any user to use our Services (or any part thereof) who infringes the intellectual property rights of others. The Digital Millennium Copyright Act of 1998 (the “DMCA”) provides recourse for copyright owners who believe that material appearing on the Internet infringes their rights under U.S. copyright law. If you have evidence, know, or have a good faith belief that your work has been copied in a way that constitutes copyright infringement or are aware of someone doing so, please contact us and include the following information:


(i) a physical or electronic signature of the owner of the copyright or a person authorized to act on behalf of the owner;

(ii) identification of the copyrighted work claimed to have been infringed (or if multiple copyrighted works located on the Website and/or Mobile App are covered by a single notification, a representative list of such works);

(iii) identification of the material that is claimed to be infringing or the subject of infringing activity, and information reasonably sufficient to allow us to locate the material on our Website and/or Mobile App;

(iv) your name, mailing address, telephone number and email address;

(v) a statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent or the law; and

(vi) a statement by you that the information in your notification is accurate, and that you attest under penalty of perjury, that you are the copyright owner or that you are authorized to act on the copyright owner’s behalf.


If you believe in good faith that a notice of copyright infringement has been wrongly filed against you, the DMCA permits you to send us a counter-notice. Notices and counter-notices with respect to the Services should be sent to our designated agent for notice of claims of copyright infringement: Eat Well Tracker, Inc., 450 West 33rd Street, New York, NY 10001, Attn: Copyright Agent, or via email at support@Eat Well Tracker.com.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """21. INDEMNIFICATION

Without limiting any indemnification provisions of these Terms & Conditions, you agree to indemnify, hold harmless and, at our option, defend Eat Well Tracker and our affiliates, and our and their respective officers, directors, members, employees, stockholders, managers, agents and representatives (collectively, “Eat Well Tracker Indemnified Parties”) from any and all third party claims, actions, demands, causes of action, liability, damages and/or costs (including, but not limited to, reasonable attorneys’ fees and expenses) (collectively, “Claims”) arising from (i) your improper use of the Services or our products or offerings, (ii) your violation of these Terms & Conditions, (iii) your provision to Eat Well Tracker or any of the Indemnified Parties of information or other data, (iv) your infringement or alleged infringement, or the infringement or use (or alleged infringement or alleged use) by any other user of your account, of any intellectual property or other right of any person or entity, or (v) your violation or alleged violation of any foreign or domestic, federal, state or local law or regulation.


The Indemnified Parties will have the right, but not the obligation, to participate through counsel of their choice in any defense by you of any Claim as to which you are required to defend, indemnify or hold harmless the Indemnified Parties. You may not settle any Claim without the prior written consent of the concerned Indemnified Parties.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,

                    ),
                    CustomText(
                      text: """22. GOVERNING LAW AND VENUE

These Terms & Conditions shall be governed by and construed in accordance with the laws of the State of Georgia, without giving effect to any principles of conflicts of law. You agree that any action at law or in equity arising out of or relating to your use of the Services or these Terms & Conditions shall be filed only in the state or federal courts located in New York County in the State of New York and you hereby consent and submit to the personal jurisdiction of such courts for the purposes of litigating any such action.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    ),
                    CustomText(
                      text: """23. TERM AND TERMINATION

a. Termination. These Terms & Conditions will remain in full force and effect while you use our Services (including our Website and Mobile Apps). We may terminate your use of, or access to, the Service in accordance with these Terms & Conditions.


b. Effect of Termination; Survival. Termination of these Terms & Conditions automatically terminates all rights and licenses granted to you under these Terms & Conditions, including all rights to use the Services, except that all terms that by their nature may survive termination shall be deemed to survive such termination (including, without limitation, intellectual property, disclaimers, limitations of liability, User Content license, governing law and venue). Subsequent to termination, Eat Well Tracker reserves the right to exercise whatever means it deems necessary to prevent your unauthorized use of the Services, including without limitation technological barriers such as IP blocking and direct contact with your Internet Service Provider.


c. Legal Action. If we, in our sole discretion, take legal action against you in connection with any actual or suspected breach of these Terms & Conditions, we will be entitled to recover from you as part of such legal action, and you agree to pay, our reasonable costs and attorneys’ fees incurred as a result of such legal action. The Eat Well Tracker Parties will have no legal obligation or other liability to you or to any third party arising out of or relating to any termination of these Terms & Conditions.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,

                    ),
                    CustomText(

                      text: """24. MISCELLANEOUS TERMS

If any provision of these terms shall be found by a court of competent jurisdiction to be unlawful, invalid, void or voidable, or for any reason unenforceable, then that provision shall be deemed severable from these terms and shall not affect the validity and enforceability of any remaining provisions. These Terms & Conditions are the entire agreement between you and us relating to the subject matter herein. We may assign our rights and obligations under these Terms & Conditions. These Terms & Conditions will inure to the benefit of our successors, assigns and licensees. The failure of either party to insist upon or enforce the strict performance of the other party with respect to any provision of these Terms & Conditions, or to exercise any right under the Terms & Conditions, will not be construed as a waiver or relinquishment to any extent of such party’s right to assert or rely upon any such provision or right in that or any other instance; rather, the same will be and remain in full force and effect.


Copyright © 2023 Eat Well Tracker, LLC. All Rights Reserved.

""",
                      align: TextAlign.justify,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyBlack,
                    )

          ],
        ),
      ),
    );
  }
}
