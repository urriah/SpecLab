// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuildingPage extends StatefulWidget {
  final List<Map<String, dynamic>> savedBuilds;

  const BuildingPage({super.key, required this.savedBuilds});

  @override
  _BuildingPageState createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {
  final Map<String, String> _selectedItems = {}; // Store selected items for each component
  final Map<String, List<String>> _compatibilityMap = {
    'Intel Core i3-12100F': [
      'MSI PRO B660M-A DDR4',
      'ASUS Prime B660M-A D4',
      'Gigabyte B660M DS3H AX DDR4',
      'ASRock B660M Pro RS',
    ],
    'Intel Core i5-12400F': [
      'MSI PRO B660M-A DDR4',
      'ASUS TUF Gaming B660-PLUS',
      'ASRock B660M Steel Legend',
      'Gigabyte B660M AORUS PRO AX',
    ],
    'Intel Core i7-13700K': [
      'ASUS ROG Strix Z690-F',
      'Gigabyte Z690 AORUS Elite AX',
      'MSI MPG Z690 Carbon WiFi',
      'ASRock Z690 Phantom Gaming 4',
    ],
    'Intel Core i9-13900K': [
      'ASUS ROG Maximus Z790 Hero',
      'MSI MEG Z790 ACE',
      'Gigabyte Z790 AORUS Master',
      'ASRock Z790 Taichi',
    ],
    'AMD Ryzen 5 5600X': [
      'MSI B550 Tomahawk',
      'ASRock B550 Steel Legend',
      'ASUS TUF Gaming B550-PLUS',
      'Gigabyte B550 AORUS Elite',
    ],
    'AMD Ryzen 7 5800X': [
      'MSI MPG B550 Gaming Plus',
      'Gigabyte B550 Vision D',
      'ASUS ROG Strix B550-F',
      'ASRock B550 Phantom Gaming 4',
    ],
    'AMD Ryzen 7 7700X': [
      'ASUS ROG Strix B650E-F',
      'Gigabyte B650 AORUS Elite AX',
      'MSI PRO B650-P WiFi',
      'ASRock B650M PG Riptide',
    ],
    'AMD Ryzen 9 7950X': [
      'ASUS ROG Crosshair X670E Hero',
      'Gigabyte X670E AORUS Master',
      'MSI MEG X670E ACE',
      'ASRock X670E Taichi',
    ],
  };

  // Helper to determine RAM type based on selected motherboard
  String? _getSelectedMoboRamType() {
    final mobo = _selectedItems['Motherboard'] ?? '';
    if (mobo.contains('DDR5')) return 'DDR5';
    if (mobo.contains('DDR4')) return 'DDR4';
    // Add more logic if you have motherboards with both types
    return null;
  }

  List<String> _getCompatibleMemoryOptions() {
    final ramType = _getSelectedMoboRamType();
    List<String> ddr4 = [
      'None',
      '8GB DDR4',
      '16GB DDR4',
      '32GB DDR4',
      '64GB DDR4',
      '128GB DDR4',
    ];
    List<String> ddr5 = [
      'None',
      '8GB DDR5',
      '16GB DDR5',
      '32GB DDR5',
      '64GB DDR5',
      '128GB DDR5',
    ];
    if (ramType == 'DDR4') return ddr4;
    if (ramType == 'DDR5') return ddr5;
    // If no MOBO or unknown, show all
    return [
      'None',
      '8GB DDR4',
      '16GB DDR4',
      '32GB DDR4',
      '64GB DDR4',
      '128GB DDR4',
      '8GB DDR5',
      '16GB DDR5',
      '32GB DDR5',
      '64GB DDR5',
      '128GB DDR5',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF381E72)),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the Dashboard
          },
        ),
        title: const Text(
          'Start Crafting',
          style: TextStyle(
            fontFamily: 'Alexandria',
            color: Color(0xFF381E72),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/Logo_Trsp.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Start Crafting',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF381E72),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Your Selections',
                    style: TextStyle(
                      fontFamily: 'Alexandria-Light',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildComponentCard(
                  context,
                  'Processor',
                  'assets/images/CPU.png',
                  [
                    'None',
                    'Intel Core i3-12100F',
                    'Intel Core i5-12400F',
                    'Intel Core i7-13700K',
                    'Intel Core i9-13900K',
                    'AMD Ryzen 5 5600X',
                    'AMD Ryzen 7 5800X',
                    'AMD Ryzen 7 7700X',
                    'AMD Ryzen 9 7950X'
                  ],
                ),
                _buildComponentCard(
                  context,
                  'GPU',
                  'assets/images/GPU.png',
                  [
                    'None',
                    'NVIDIA GeForce RTX 3060 Ti',
                    'NVIDIA GeForce RTX 3070',
                    'NVIDIA GeForce RTX 4070 Super',
                    'NVIDIA GeForce RTX 4080',
                    'AMD Radeon RX 6700 XT',
                    'AMD Radeon RX 6800',
                    'AMD Radeon RX 7900 XT',
                    'AMD Radeon RX 7900 XTX'
                  ],
                ),
                _buildComponentCard(
                  context,
                  'Motherboard',
                  'assets/images/MB.png',
                  _getCompatibleComponents('Motherboard'),
                ),
                _buildComponentCard(
                  context,
                  'Memory',
                  'assets/images/RAM.png',
                  _getCompatibleMemoryOptions(),
                ),
                _buildComponentCard(
                  context,
                  'Storage',
                  'assets/images/Storage.png',
                  [
                    'None',
                    '1TB HDD',
                    '2TB HDD',
                    '4TB HDD',
                    '256GB SSD',
                    '512GB SSD',
                    '1TB SSD',
                    '2TB SSD',
                    '500GB NVMe',
                    '1TB NVMe',
                    '2TB NVMe',
                  ],
                ),
                _buildComponentCard(
                  context,
                  'PSU',
                  'assets/images/PSU.png',
                  _getCompatiblePSUOptions(),
                ),
                _buildComponentCard(
                  context,
                  'Cooling',
                  'assets/images/FAN.png',
                  [
                    'None',
                    'Air Cooler',
                    'Liquid Cooler',
                    'Noctua NH-D15',
                    'Cooler Master Hyper 212',
                    'Corsair iCUE H150i',
                    'NZXT Kraken X63',
                    'be quiet! Dark Rock Pro 4',
                  ],
                ),
                _buildComponentCard(
                  context,
                  'Case',
                  'assets/images/Case.png',
                  [
                    'None',
                    'Mid Tower',
                    'Full Tower',
                    'Mini Tower',
                    'Corsair 4000D',
                    'NZXT H510',
                    'Fractal Design Meshify C',
                    'Lian Li PC-O11 Dynamic',
                    'Phanteks Eclipse P400A',
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedItems.isNotEmpty) {
                        _showSaveDialog(context);
                      } else {
                        // Show a message if no components are selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select components before saving!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF381E72),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Build'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Build Name',
              hintText: 'Enter a name for your build',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String buildName = nameController.text.trim();
                if (buildName.isNotEmpty) {
                  // Send build to Django backend
                  final response = await http.post(
                    Uri.parse('https://crud-mryv.onrender.com/builds/create/'),
                    headers: {'Content-Type': 'application/json'},
                    body: json.encode({
                      'name': buildName,
                      'components': Map<String, String>.from(_selectedItems),
                    }),
                  );

                  if (response.statusCode == 201) {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Close the BuildingPage
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your Build Has Been Saved'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save build: ${response.body}'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a name for your build!'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComponentCard(BuildContext context, String title, String imagePath, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF381E72),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Available options:',
                  style: TextStyle(
                    fontFamily: 'Alexandria-Light',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {
                    _showOptions(context, title, options);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: _selectedItems[title] != null
                          ? const Color(0xFF381E72)
                          : const Color(0xFFD9D9D9),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _selectedItems[title] ?? 'Select',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      color: _selectedItems[title] != null
                          ? const Color(0xFF381E72)
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, String title, List<String> options) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to take more space
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Select $title',
                    style: const TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF381E72),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: options.map(
                        (option) => ListTile(
                          title: Text(
                            option,
                            style: const TextStyle(fontFamily: 'Alexandria'),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedItems[title] = option;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<String> _getCompatibleComponents(String componentType) {
    if (componentType == 'Motherboard' && _selectedItems.containsKey('Processor')) {
      return ['None', ...(_compatibilityMap[_selectedItems['Processor']] ?? [])];
    }
    return ['None'];
  }

  // PSU compatibility logic
  int _estimateRequiredWattage() {
    final cpu = _selectedItems['Processor'] ?? '';
    final gpu = _selectedItems['GPU'] ?? '';

    int wattage = 150; // base system

    // CPU wattage
    if (cpu.contains('i9') || cpu.contains('Ryzen 9')) wattage += 150;
    else if (cpu.contains('i7') || cpu.contains('Ryzen 7')) wattage += 120;
    else if (cpu.contains('i5') || cpu.contains('Ryzen 5')) wattage += 90;
    else if (cpu.isNotEmpty && cpu != 'None') wattage += 70;

    // GPU wattage
    if (gpu.contains('RTX 4080') || gpu.contains('RX 7900 XTX')) wattage += 320;
    else if (gpu.contains('RTX 4070') || gpu.contains('RX 7900 XT')) wattage += 280;
    else if (gpu.contains('RTX 3070') || gpu.contains('RX 6800')) wattage += 220;
    else if (gpu.contains('RTX 3060') || gpu.contains('RX 6700')) wattage += 170;
    else if (gpu.isNotEmpty && gpu != 'None') wattage += 120;

    return wattage;
  }

  List<String> _getCompatiblePSUOptions() {
    // Use only realistic, commonly available PSU wattages
    final allPSUs = [
      'None',
      '400W',
      '450W',
      '500W',
      '550W',
      '600W',
      '650W',
      '700W',
      '750W',
      '800W',
      '850W',
      '1000W',
      '1200W',
      'Corsair RM750x',
      'EVGA SuperNOVA 850 G5',
      'Seasonic Focus GX-650',
    ];

    int required = _estimateRequiredWattage();

    List<String> filtered = allPSUs.where((psu) {
      if (psu == 'None') return true;
      final match = RegExp(r'(\d{3,4})W').firstMatch(psu);
      if (match != null) {
        int psuWatt = int.parse(match.group(1)!);
        return psuWatt >= required;
      }
      // For named PSUs, include if their wattage is in the name and sufficient
      if (psu.contains('750') && required <= 750) return true;
      if (psu.contains('850') && required <= 850) return true;
      if (psu.contains('650') && required <= 650) return true;
      if (psu.contains('1000') && required <= 1000) return true;
      if (psu.contains('1200') && required <= 1200) return true;
      return false;
    }).toList();

    if (!filtered.contains('None')) filtered.insert(0, 'None');
    return filtered;
  }
}