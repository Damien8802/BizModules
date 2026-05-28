import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HRScreen extends StatefulWidget {
  const HRScreen({super.key});

  @override
  State<HRScreen> createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  int _selectedTab = 0;
  List<dynamic> employees = [];
  List<dynamic> vacations = [];
  Map<String, dynamic> statistics = {};
  bool isLoading = true;
  String? errorMessage;

  final String apiUrl = 'http://212.67.12.38:8080'; // замени на свой IP, если надо

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final statRes = await http.get(Uri.parse('$apiUrl/hr/api/statistics'));
      final empRes = await http.get(Uri.parse('$apiUrl/hr/api/employees'));
      final vacRes = await http.get(Uri.parse('$apiUrl/hr/api/vacations'));

      if (statRes.statusCode == 200) {
        final data = jsonDecode(statRes.body);
        statistics = data['statistics'] ?? {};
      }
      if (empRes.statusCode == 200) {
        final data = jsonDecode(empRes.body);
        employees = data['employees'] ?? [];
      }
      if (vacRes.statusCode == 200) {
        final data = jsonDecode(vacRes.body);
        vacations = data['requests'] ?? [];
      }
    } catch (e) {
      setState(() => errorMessage = 'Ошибка загрузки: $e');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text('👥 HR модуль', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabItem('Дашборд', 0),
          _buildTabItem('Сотрудники', 1),
          _buildTabItem('Отпуска', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF667EEA) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)));
    }
    switch (_selectedTab) {
      case 0: return _buildDashboard();
      case 1: return _buildEmployeesList();
      case 2: return _buildVacationsList();
      default: return const SizedBox();
    }
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildStatCard('Сотрудников', statistics['totalEmployees'] ?? 0, Icons.people),
          _buildStatCard('В отпуске', statistics['vacationCount'] ?? 0, Icons.beach_access),
          _buildStatCard('Заявок', statistics['pendingRequests'] ?? 0, Icons.request_page),
          _buildStatCard('Кандидатов', statistics['candidatesCount'] ?? 0, Icons.person_search),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: const Color(0xFF667EEA)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white54)),
              Text('$value', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesList() {
    if (employees.isEmpty) {
      return const Center(child: Text('Нет сотрудников', style: TextStyle(color: Colors.white54)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final emp = employees[index];
        return Card(
          color: const Color(0xFF16213E),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF667EEA)),
            title: Text(emp['full_name'] ?? 'Без имени', style: const TextStyle(color: Colors.white)),
            subtitle: Text('${emp['position'] ?? ''} • ${emp['department'] ?? ''}', style: const TextStyle(color: Colors.white70)),
            trailing: Chip(
              label: Text(emp['status'] ?? 'Активен', style: const TextStyle(color: Colors.white)),
              backgroundColor: (emp['status'] == 'active') ? Colors.green.withOpacity(0.2) : (emp['status'] == 'vacation') ? Colors.orange.withOpacity(0.2) : Colors.red.withOpacity(0.2),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVacationsList() {
    if (vacations.isEmpty) {
      return const Center(child: Text('Нет заявок на отпуск', style: TextStyle(color: Colors.white54)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vacations.length,
      itemBuilder: (context, index) {
        final vac = vacations[index];
        return Card(
          color: const Color(0xFF16213E),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.beach_access, color: Color(0xFF667EEA)),
            title: Text(vac['employee_name'] ?? 'Сотрудник', style: const TextStyle(color: Colors.white)),
            subtitle: Text('${vac['type'] ?? ''} • ${vac['start_date'] ?? ''} → ${vac['end_date'] ?? ''}', style: const TextStyle(color: Colors.white70)),
            trailing: Chip(
              label: Text(vac['status'] ?? 'Активен', style: const TextStyle(color: Colors.white)),
              backgroundColor: (vac['status'] == 'approved') ? Colors.green.withOpacity(0.2) : (vac['status'] == 'pending') ? Colors.orange.withOpacity(0.2) : Colors.red.withOpacity(0.2),
            ),
          ),
        );
      },
    );
  }
}
