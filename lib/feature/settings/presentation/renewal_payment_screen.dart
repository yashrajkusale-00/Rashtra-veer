import 'package:flutter/material.dart';
import 'package:rashtraveer/feature/onboarding/presentation/payment_screen.dart';

class RenewalPaymentScreen extends StatefulWidget {
  static const String routeName = "/renewal-payment";

  const RenewalPaymentScreen({super.key});

  @override
  State<RenewalPaymentScreen> createState() =>
      _RenewalPaymentScreenState();
}

class _RenewalPaymentScreenState
    extends State<RenewalPaymentScreen> {
  static const Color primary = Color(0xFF6A66FF);

  int selectedIndex = 1;

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Basic",
      "price": 100,
      "desc": "Starter access",
    },
    {
      "title": "Popular",
      "price": 200,
      "desc": "Most selected",
    },
    {
      "title": "Premium",
      "price": 400,
      "desc": "Full access",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final current = plans[selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),

      appBar: AppBar(
        title: const Text("Subscription & Payments"),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),

      /// 🔥 Bottom CTA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                /// 🔥 Open existing PaymentScreen
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      planTitle:
                          current["title"].toString(),
                      planPrice:
                          current["price"] as int,
                    ),
                  ),
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Payment Completed",
                    ),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    primary,
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 16,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                              12),
                ),
              ),
              child: Text(
                "Continue with ₹${current["price"]}",
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            /// 🔥 Top Card
            Container(
              width:
                  double.infinity,
              padding:
                  const EdgeInsets
                      .all(18),
              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    primary,
                    Color(
                        0xFF514BEF),
                  ],
                ),
                borderRadius:
                    BorderRadius
                        .circular(
                            18),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    "Membership Expiring Soon",
                    style:
                        TextStyle(
                      color: Colors
                          .white70,
                    ),
                  ),
                  SizedBox(
                      height: 8),
                  Text(
                    "Renew now and keep your progress active.",
                    style:
                        TextStyle(
                      color: Colors
                          .white,
                      fontSize:
                          18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  SizedBox(
                      height: 8),
                  Text(
                    "Expires: 30 Sept 2026",
                    style:
                        TextStyle(
                      color: Colors
                          .white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 24),

            const Text(
              "Choose Your Plan",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight
                        .bold,
              ),
            ),

            const SizedBox(
                height: 14),

            /// 🔥 Plan Cards
            ...List.generate(
              plans.length,
              (index) {
                final item =
                    plans[index];

                final selected =
                    selectedIndex ==
                        index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex =
                          index;
                    });
                  },
                  child:
                      AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds:
                          250,
                    ),
                    margin:
                        const EdgeInsets
                            .only(
                      bottom: 12,
                    ),
                    padding:
                        const EdgeInsets
                            .all(
                      16,
                    ),
                    decoration:
                        BoxDecoration(
                      color: Colors
                          .white,
                      borderRadius:
                          BorderRadius.circular(
                              16),
                      border:
                          Border.all(
                        color:
                            selected
                                ? primary
                                : Colors.grey.shade300,
                        width:
                            selected
                                ? 2
                                : 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color:
                              Colors.black12,
                          blurRadius:
                              8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color:
                              primary,
                        ),

                        const SizedBox(
                            width:
                                12),

                        Expanded(
                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item["title"]
                                        .toString(),
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  if (index ==
                                      1)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left:
                                              8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              8,
                                          vertical:
                                              3),
                                      decoration:
                                          BoxDecoration(
                                        color:
                                            Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(
                                                20),
                                      ),
                                      child:
                                          const Text(
                                        "BEST",
                                        style:
                                            TextStyle(
                                          color:
                                              Colors.white,
                                          fontSize:
                                              10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(
                                  height:
                                      4),

                              Text(
                                item["desc"]
                                    .toString(),
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "₹${item["price"]}",
                          style:
                              const TextStyle(
                            fontSize:
                                20,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
                height: 20),

            const Text(
              "Why Renew?",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight
                        .bold,
              ),
            ),

            const SizedBox(
                height: 12),

            const _Benefit(
                "Continue premium workouts"),
            const _Benefit(
                "Maintain streak & badges"),
            const _Benefit(
                "Unlimited videos"),
            const _Benefit(
                "Coach support"),

            const SizedBox(
                height: 20),

            const Center(
              child: Text(
                "Secure payments via Razorpay",
                style: TextStyle(
                  color:
                      Colors.grey,
                ),
              ),
            ),

            const SizedBox(
                height: 100),
          ],
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final String text;

  const _Benefit(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 18,
          ),
          const SizedBox(
              width: 8),
          Text(text),
        ],
      ),
    );
  }
}