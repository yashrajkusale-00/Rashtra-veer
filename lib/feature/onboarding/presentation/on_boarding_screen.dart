import 'package:flutter/material.dart';

enum BMIState { input, loading, result }

class Onboardingscreen1 extends StatefulWidget {
  const Onboardingscreen1({super.key});

  @override
  State<Onboardingscreen1> createState() => _Onboardingscreen1State();
}

class _Onboardingscreen1State extends State<Onboardingscreen1> {
  double height = 170; // cm
  double weight = 65; // kg
  int age = 22;
  String gender = "Male";
  BMIState currentState = BMIState.input;
  double bmi = 0;
  // double get bmi => weight / ((height / 100) * (height / 100));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Colors.grey),
                      SizedBox(width: 6),
                      Text("English", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _buildCurrentView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 GENDER CARD
  Widget _buildGenderCard(String type) {
    final isSelected = gender == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => gender = type);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4C4A99) : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                type == "Male" ? Icons.male : Icons.female,
                color: isSelected ? Colors.white : Colors.grey,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                type,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 SLIDER CARD
  Widget _buildSliderCard({
    required String title,
    required double value,
    required String unit,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            "${value.toInt()} $unit",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF4C4A99),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // 🔹 COUNTER CARD
  Widget _buildCounterCard({
    required String title,
    required int value,
    required String unit,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            "$value $unit",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              IconButton(
                onPressed: onAdd,
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    String result;
    Color color;

    if (bmi < 18.5) {
      result = "Underweight";
      color = Colors.blue;
    } else if (bmi < 25) {
      result = "Normal";
      color = Colors.green;
    } else if (bmi < 30) {
      result = "Overweight";
      color = Colors.orange;
    } else {
      result = "Obese";
      color = Colors.red;
    }

    return Column(
      key: const ValueKey("result"),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Your BMI", style: TextStyle(color: Colors.grey)),

        const SizedBox(height: 12),

        Text(
          bmi.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),

        const SizedBox(height: 12),

        Text(result, style: TextStyle(fontSize: 20, color: color)),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF4C4A99),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                currentState = BMIState.input;
              });
            },
            child: const Text(
              "Recalculate",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput() {
    return SingleChildScrollView(
      key: const ValueKey("input"),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "BMI Calculator",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C4A99),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              _buildGenderCard("Male"),
              const SizedBox(width: 12),
              _buildGenderCard("Female"),
            ],
          ),

          const SizedBox(height: 24),

          _buildSliderCard(
            title: "Height",
            value: height,
            unit: "cm",
            min: 100,
            max: 220,
            onChanged: (val) {
              setState(() => height = val);
            },
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildCounterCard(
                  title: "Weight",
                  value: weight.toInt(),
                  unit: "kg",
                  onAdd: () => setState(() => weight++),
                  onRemove: () => setState(() => weight--),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCounterCard(
                  title: "Age",
                  value: age,
                  unit: "",
                  onAdd: () => setState(() => age++),
                  onRemove: () => setState(() => age--),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF4C4A99),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                setState(() {
                  currentState = BMIState.loading;
                });

                await Future.delayed(const Duration(seconds: 2));

                bmi = weight / ((height / 100) * (height / 100));

                setState(() {
                  currentState = BMIState.result;
                });
              },
              child: const Text(
                "Calculate BMI",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (currentState) {
      case BMIState.loading:
        return _buildLoading();
      case BMIState.result:
        return _buildResult();
      default:
        return _buildInput();
    }
  }

  Widget _buildLoading() {
    return Column(
      key: const ValueKey("loading"),
      mainAxisSize: MainAxisSize.min,
      children: const [
        CircularProgressIndicator(color: Color(0xFF4C4A99)),
        SizedBox(height: 20),
        Text("Calculating BMI..."),
      ],
    );
  }
}
