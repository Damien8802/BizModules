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
  const Module(id: 'ai', name: 'AI Агенты', icon: '🤖', description: 'Искусственный интеллект'),
  const Module(id: 'ai_media', name: 'AI Media Studio', icon: '🎬', description: 'Генерация фото, видео и фильмов'),
  const Module(id: 'archive', name: 'Архив', icon: '📦', description: 'Архивация'),
  const Module(id: 'marketplace', name: 'Маркетплейс', icon: '🛒', description: 'Товары и услуги'),
  const Module(id: 'security_24_7', name: 'ОХРАНА 24/7', icon: '🚔', description: 'Модуль для ЧОП — контроль охраны'),
];