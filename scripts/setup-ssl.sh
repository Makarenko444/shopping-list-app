#!/bin/bash

# 🔒 Скрипт для установки SSL сертификата (Let's Encrypt)
# Использование: sudo bash setup-ssl.sh example.com

set -e

# Цвета
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Проверка что скрипт запущен с sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✗ Запустите скрипт с sudo: sudo bash setup-ssl.sh example.com${NC}"
    exit 1
fi

# Проверка что указан домен
if [ -z "$1" ]; then
    echo -e "${RED}✗ Укажите домен!${NC}"
    echo "Использование: sudo bash setup-ssl.sh example.com"
    exit 1
fi

DOMAIN=$1

echo -e "${BLUE}🔒 Установка SSL сертификата для $DOMAIN${NC}"
echo ""

# Установка Certbot
echo -e "${BLUE}▶ Установка Certbot...${NC}"
apt update
apt install -y certbot python3-certbot-nginx

echo -e "${GREEN}✓ Certbot установлен${NC}"
echo ""

# Получение сертификата
echo -e "${BLUE}▶ Получение SSL сертификата...${NC}"
echo "Следуйте инструкциям:"
echo ""

certbot --nginx -d $DOMAIN

echo ""
echo -e "${GREEN}✓ SSL сертификат установлен${NC}"
echo ""

# Проверка автоматического обновления
echo -e "${BLUE}▶ Настройка автоматического обновления...${NC}"
systemctl status certbot.timer

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}🎉 SSL настроен успешно!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔒 Ваш сайт теперь доступен по HTTPS:"
echo -e "   ${GREEN}https://$DOMAIN${NC}"
echo ""
echo "📝 Сертификат будет автоматически обновляться каждые 60 дней"
echo ""
echo "🧪 Проверить обновление можно командой:"
echo "   sudo certbot renew --dry-run"
echo ""
