#!/bin/bash

# 🚀 Скрипт для первоначального развертывания проекта на VPS
# Использование: bash deploy.sh

set -e  # Остановить при ошибке

echo "🚀 Начинаем развертывание Shopping List App..."
echo ""

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Функция для вывода шагов
step() {
    echo -e "${BLUE}▶ $1${NC}"
}

success() {
    echo -e "${GREEN}✓ $1${NC}"
}

error() {
    echo -e "${RED}✗ $1${NC}"
}

# Проверка что скрипт запущен с sudo
if [ "$EUID" -ne 0 ]; then
    error "Запустите скрипт с sudo: sudo bash deploy.sh"
    exit 1
fi

# 1. Обновление системы
step "Обновление системы..."
apt update && apt upgrade -y
success "Система обновлена"
echo ""

# 2. Установка необходимых пакетов
step "Установка Nginx и Git..."
apt install -y nginx git
success "Nginx и Git установлены"
echo ""

# 3. Создание директории для проекта
step "Создание директории для проекта..."
mkdir -p /var/www/shopping-list
cd /var/www/shopping-list
success "Директория создана: /var/www/shopping-list"
echo ""

# 4. Клонирование проекта
step "Клонирование проекта с GitHub..."
if [ -d ".git" ]; then
    echo "Проект уже существует, обновляем..."
    git pull
else
    git clone https://github.com/Makarenko444/shopping-list-app.git .
fi
success "Проект склонирован"
echo ""

# 5. Настройка прав доступа
step "Настройка прав доступа..."
chown -R www-data:www-data /var/www/shopping-list
chmod -R 755 /var/www/shopping-list
success "Права настроены"
echo ""

# 6. Создание конфигурации Nginx
step "Создание конфигурации Nginx..."

# Получаем IP сервера
SERVER_IP=$(hostname -I | cut -d' ' -f1)

cat > /etc/nginx/sites-available/shopping-list <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name $SERVER_IP;

    root /var/www/shopping-list;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # Кэширование статических файлов
    location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Gzip сжатие
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
EOF

success "Конфигурация Nginx создана"
echo ""

# 7. Активация конфигурации
step "Активация конфигурации..."
ln -sf /etc/nginx/sites-available/shopping-list /etc/nginx/sites-enabled/
success "Конфигурация активирована"
echo ""

# 8. Проверка конфигурации Nginx
step "Проверка конфигурации Nginx..."
if nginx -t; then
    success "Конфигурация корректна"
else
    error "Ошибка в конфигурации Nginx!"
    exit 1
fi
echo ""

# 9. Перезапуск Nginx
step "Перезапуск Nginx..."
systemctl reload nginx
systemctl enable nginx
success "Nginx перезапущен и добавлен в автозагрузку"
echo ""

# 10. Настройка файрвола
step "Настройка файрвола..."
ufw allow 'Nginx Full'
ufw allow OpenSSH
success "Файрвол настроен"
echo ""

# 11. Создание скрипта обновления
step "Создание скрипта автоматического обновления..."
cat > /usr/local/bin/update-shopping-list.sh <<'EOF'
#!/bin/bash

echo "🔄 Обновление Shopping List App..."

cd /var/www/shopping-list

# Сохранить изменения (если есть)
git stash

# Получить последние изменения
git pull origin main || git pull origin master

# Восстановить изменения
git stash pop 2>/dev/null || true

# Установить права
chown -R www-data:www-data /var/www/shopping-list
chmod -R 755 /var/www/shopping-list

echo "✅ Обновление завершено!"
echo "🌐 Проверьте сайт"
EOF

chmod +x /usr/local/bin/update-shopping-list.sh
success "Скрипт обновления создан: /usr/local/bin/update-shopping-list.sh"
echo ""

# Завершение
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}🎉 Развертывание завершено успешно!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📍 Ваш сайт доступен по адресу:"
echo -e "${BLUE}   http://$SERVER_IP${NC}"
echo ""
echo "🔄 Для обновления сайта используйте:"
echo "   sudo /usr/local/bin/update-shopping-list.sh"
echo ""
echo "📝 Следующие шаги:"
echo "   1. Откройте http://$SERVER_IP в браузере"
echo "   2. Настройте домен (опционально)"
echo "   3. Установите SSL сертификат (рекомендуется)"
echo ""
echo "📚 Подробнее: DEPLOYMENT-GUIDE.md"
echo ""
