class Module {
  final String id;
  final String name;
  final String icon;
  final String description;
  
  const Module({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

final List<Module> allModules = [
  const Module(id: 'fin', name: 'FinCore', icon: '💰', description: 'Финансы и учёт'),
  const Module(id: 'crm', name: 'CRM', icon: '🤝', description: 'Клиенты и продажи'),
  const Module(id: 'team', name: 'TeamSphere', icon: '👥', description: 'Командная работа'),
  const Module(id: 'vpn', name: 'VPN', icon: '🔒', description: 'Защита и обход блокировок'),
  const Module(id: 'cloud', name: 'Cloud Storage', icon: '☁️', description: 'Облачное хранилище'),
  const Module(id: 'stock', name: 'Складской учёт', icon: '📦', description: 'Управление складом'),
  const Module(id: 'logistics', name: 'Логистика', icon: '🚚', description: 'Доставка и перевозки'),
  const Module(id: 'hr', name: 'HR модуль', icon: '👥', description: 'Кадры и персонал'),
  const Module(id: 'ai', name: 'AI Агенты', icon: '🤖', description: 'Искусственный интеллект'),
  const Module(id: 'security', name: 'Безопасность', icon: '🛡️', description: 'Защита данных'),
  const Module(id: 'migration', name: 'Миграция данных', icon: '🔄', description: 'Перенос данных'),
  const Module(id: 'archive', name: 'Архив', icon: '📦', description: 'Архивация'),
  const Module(id: 'identity', name: 'Identity Hub', icon: '🔐', description: 'Управление доступом'),
  const Module(id: 'marketplace', name: 'Маркетплейс', icon: '🛒', description: 'Товары и услуги'),
];
