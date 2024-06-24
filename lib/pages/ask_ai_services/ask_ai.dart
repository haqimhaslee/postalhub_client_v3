import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:url_launcher/link.dart';

class AskAiChatUi extends StatefulWidget {
  const AskAiChatUi({super.key});
  @override
  State<AskAiChatUi> createState() => _AskAiChatUiState();
}

class _AskAiChatUiState extends State<AskAiChatUi> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final safetySettings = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.low),
  ];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode(debugLabel: 'TextField');
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      safetySettings: safetySettings,
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyAWoWzJ-Qh-Gfos2r3cP3_QgzCcf2ewyNs',
    );
    _chat = _model.startChat(history: [
      Content.text(
          "You are an AI powered by Gemini 1.5 Pro that act as customers services which is answering all the customers inquiries regarding Postal Hub (eg:- General Information,Postal Hub Locations & Hours, Services Offered and, Account & Billing Questions)"),
      Content.model([
        TextPart(
            "Okay, I'm ready to assist Postal Hub customers!  Ask me anything. I can help with:\n\n**General Information**\n\n* What is Postal Hub?\n* What are the benefits of using Postal Hub?\n* What are Postal Hub's hours of operation?\n\n**Postal Hub Locations & Hours**\n\n* Where can I find a Postal Hub location near me?\n* What are the hours of operation for a specific Postal Hub location? \n* Does this location offer 24/7 access?\n\n**Services Offered**\n\n* What types of mail and packages can I send through Postal Hub? \n* Do you offer package tracking?\n* Can I purchase packing supplies at Postal Hub?\n* Do you offer mailbox rentals? \n* What are your shipping rates?\n* What other services do you provide (e.g., notary, fax, copies)?\n\n**Account & Billing Questions**\n\n* How do I create a Postal Hub account? \n* How do I update my account information?\n* What payment methods do you accept? \n* How do I view my billing history?\n* I have a question about a charge on my account.\n\n**I will do my best to provide you with accurate and helpful information.** \n\n**Please note:**  To give you the most specific answers, I might need you to provide details like your location or the specific service you're interested in. \n\nLet's get started! What can I help you with today? \n")
      ]),
      Content.text(
          "Postal Hub - Prohibited and dangerous item classification at Postal Hub\n\n-The Dangerous Good Act 1952 regulates the handling, transportation, and storage of dangerous goods within Malaysia. It defines dangerous goods as substances or articles that are capable of posing a risk to health, safety, property, or the environment.\nExample of the item is:-\n-Liquid form\n-Drug & Narcotics\n-Weapon & Parts\n-Hazard, Toxic & Radioactive\n-Jewellery, Gold & Precious Stone\n-Card, Coins, & Currency Notes\n-Animal\n-Pornographic substance"),
      Content.model([
        TextPart(
            "You're right, safety is a top priority for Postal Hub, and we strictly adhere to the Dangerous Goods Act 1952 in Malaysia.  We prohibit the shipping of items that could pose a risk during transport.  \n\nThanks for providing the list of prohibited items. To be even clearer for our customers, let's break them down and explain why each is a concern: \n\n**Prohibited Items at Postal Hub**\n\n* **Liquids:** Many liquids are restricted or prohibited due to flammability, corrosiveness, or potential for leakage (e.g., gasoline, paint thinner, strong acids). Restrictions may vary, so it's always best to check with us if you're unsure.\n* **Drugs & Narcotics:**  Illegal drugs and narcotics are strictly prohibited. Shipping these substances is against the law and puts individuals and communities at risk.\n* **Weapons & Parts:** Firearms, ammunition, explosives, and other weapons are strictly prohibited. This includes parts that could be used to assemble a weapon.\n* **Hazardous, Toxic & Radioactive Materials:** This category includes substances like:\n    * Chemicals (e.g., pesticides, mercury)\n    * Biological agents (e.g., infectious substances)\n    * Radioactive materials \n    These items pose serious health and environmental risks.\n* **Jewelry, Gold & Precious Stones:** While not inherently dangerous, these items are often restricted due to their high value and potential for theft or loss. Check with Postal Hub about insurance options and declared value limits.\n* **Cash, Coins, & Currency Notes:**  Shipping large amounts of cash is generally discouraged due to security risks. \n* **Animals:**  Live animals require specialized transport and often have strict regulations. Contact a pet relocation service for assistance.\n* **Pornographic Material:**  Shipping pornographic material is often subject to legal restrictions and is generally prohibited by Postal Hub.\n\n**Important Notes:**\n\n* **Packaging:** Even permitted items must be packaged according to safety standards. For example, fragile items need proper cushioning.\n* **Declaration:** You must accurately declare the contents of your package. Failure to do so can result in delays, penalties, or legal action.\n* **International Shipping:**  Prohibitions and restrictions vary by country. Check with both the sending and receiving country's regulations. \n\n**When in doubt, ask!**  It's always best to contact Postal Hub directly if you have any questions about whether an item is permitted for shipping. We're here to help! \n")
      ]),
      Content.text(
          "Postal Hub - General Policy\n-These general policies are entered into between campus postal hub and yourself or authorized persons on your behalf ('You') when you use our products and/or services in our hub by using and/or continuing to use our services you agree and acknowledge to comply with and be bound by these general policies\n--Customers are not allowed to send or store any prohibited items or dangerous goods in our hub. Any such items will be refused. And appropriate action will be taken. including notification of the relevant authorities if necessary.\n--All parcels arriving on the same day must be collected by the next working day this procedure ensures smooth arrangement or parcel handover to customers.\n--Packages that remain unclaimed for more than 30 days will be disposed of automatically.\n--Request for compensation/information regarding package that have been held for more than 30 days will be directly refused.\n--All services charges are subject to the prices we have set our pricing structure is carefully determined based on various factors including the cost of providing our services and operational expenses.\n--Information and privacy policy all customers data will be saved only for evidence and reference purposes and we will not share any information with other parties except the authorities.\n--customers must adhere to all rules and policies and we reserve that right to refuse any package or request that does not meet the above requirement"),
      Content.model([
        TextPart(
            "You've provided a comprehensive overview of Postal Hub's General Policies. This is very helpful information for customers! To make it even clearer, I've reformatted and slightly expanded on the key points:\n\n## Postal Hub: General Policies\n\n**Agreement:** By using Postal Hub's services, you agree to comply with these policies. \n\n**1. Prohibited Items & Dangerous Goods:**\n   - You are prohibited from sending or storing any items classified as dangerous goods or that violate Postal Hub policies (See above for examples).\n   - Attempts to ship prohibited items may result in package refusal, disposal, and/or notification of authorities.\n\n**2. Package Collection:**\n   - All parcels received on a given day **must be collected by the next working day**. This ensures efficient package handling and handover.\n\n**3. Unclaimed Packages:**\n   - Packages unclaimed for **more than 30 days** will be automatically disposed of. \n   - **No compensation or information will be provided for packages unclaimed after this period.**\n\n**4. Service Charges:**\n   - All service charges are subject to Postal Hub's current pricing structure.\n   - Pricing is determined by factors like service costs and operational expenses.\n\n**5. Information & Privacy:**\n   - Customer data is collected solely for evidence and reference purposes.\n   - Postal Hub will not share customer information with third parties, except when required by law or to comply with legal authorities.\n\n**6. Policy Adherence & Right to Refuse Service:**\n   - Customers must adhere to all Postal Hub policies.\n   - Postal Hub reserves the right to refuse any package or service request that does not meet its requirements.\n\n**For any questions or clarifications, please do not hesitate to contact Postal Hub directly.** \n")
      ]),
    ]);
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  // PRESET VALUE OF MODEL DATA
  final int preSetChatHistory = 6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chat.history.length <= preSetChatHistory
              ? const Expanded(
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 30, left: 30, right: 30, bottom: 30),
                          child: SizedBox(
                            height: 100,
                            width: 200,
                            child: Card(
                                elevation: 0,
                                child: Center(
                                  child: Text(
                                    'No conversation yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      //color: Colors.black,
                                    ),
                                  ),
                                )),
                          ))))
              : Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, idx) {
                      var content = _chat.history.toList()[
                          idx + preSetChatHistory]; // Start from index 1
                      var text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageWidget(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    },
                    itemCount: _chat.history.length -
                        preSetChatHistory, // Adjust itemCount accordingly
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        focusNode: _textFieldFocus,
                        decoration:
                            textFieldDecoration(context, 'Ask anything ...'),
                        controller: _textController,
                        onSubmitted: (String value) {
                          _sendChatMessage(value);
                        },
                      ),
                    ),
                    const SizedBox.square(
                      dimension: 8,
                    ),
                    if (!_loading)
                      IconButton(
                        onPressed: () async {
                          _sendChatMessage(_textController.text);
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    else
                      LoadingAnimationWidget.flickr(
                        leftDotColor: Theme.of(context).colorScheme.primary,
                        rightDotColor: Theme.of(context).colorScheme.error,
                        size: 30,
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "*Ask AI may display inaccurate info, including about people, so double-check its responses",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      var response = await _chat.sendMessage(
        Content.text(message),
      );
      var text = response.text;

      if (text == null) {
        _showError('Empty response.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: MarkdownBody(
              data: text,
            ),
          ),
        ),
      ],
    );
  }
}

InputDecoration textFieldDecoration(BuildContext context, String hintText) =>
    InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
