# 💻 Практические примеры кода

## 📚 Содержание
1. [JavaScript примеры](#javascript-примеры)
2. [CSS трюки](#css-трюки)
3. [HTML паттерны](#html-паттерны)
4. [Готовые функции](#готовые-функции)

---

## JavaScript примеры

### 1. Работа с массивами

```javascript
const items = [
    { id: 1, name: 'Молоко', completed: false },
    { id: 2, name: 'Хлеб', completed: true },
    { id: 3, name: 'Яйца', completed: false }
];

// Найти элемент по ID
const item = items.find(item => item.id === 2);
console.log(item); // { id: 2, name: 'Хлеб', completed: true }

// Отфильтровать купленные товары
const bought = items.filter(item => item.completed);
console.log(bought); // [{ id: 2, name: 'Хлеб', completed: true }]

// Отфильтровать НЕкупленные товары
const notBought = items.filter(item => !item.completed);

// Посчитать количество
const totalBought = items.filter(item => item.completed).length;
console.log(totalBought); // 1

// Проверить есть ли хоть один купленный
const hasCompleted = items.some(item => item.completed);
console.log(hasCompleted); // true

// Проверить все ли купленные
const allCompleted = items.every(item => item.completed);
console.log(allCompleted); // false

// Получить только названия
const names = items.map(item => item.name);
console.log(names); // ['Молоко', 'Хлеб', 'Яйца']

// Сортировка по названию
const sorted = items.sort((a, b) => a.name.localeCompare(b.name));
```

---

### 2. Работа с датами

```javascript
// Текущая дата
const now = new Date();

// Форматирование
const formatted = now.toLocaleDateString('ru-RU');
console.log(formatted); // "24.10.2025"

// Со временем
const withTime = now.toLocaleString('ru-RU');
console.log(withTime); // "24.10.2025, 15:30:45"

// Только время
const timeOnly = now.toLocaleTimeString('ru-RU');
console.log(timeOnly); // "15:30:45"

// Разница между датами
const past = new Date('2025-01-01');
const diffMs = now - past;
const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
console.log(`Прошло дней: ${diffDays}`);

// Добавить дни к дате
function addDays(date, days) {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

const tomorrow = addDays(new Date(), 1);
```

---

### 3. Работа со строками

```javascript
const text = "  Молоко 2 литра  ";

// Убрать пробелы
text.trim(); // "Молоко 2 литра"

// Длина строки
text.length; // 18

// Перевод в верхний регистр
text.toUpperCase(); // "  МОЛОКО 2 ЛИТРА  "

// В нижний регистр
text.toLowerCase(); // "  молоко 2 литра  "

// Проверка на вхождение
text.includes('Молоко'); // true
text.includes('молоко'); // false (регистр важен!)

// Начинается с...
text.trim().startsWith('Молоко'); // true

// Заканчивается на...
text.trim().endsWith('литра'); // true

// Замена
text.replace('Молоко', 'Кефир'); // "  Кефир 2 литра  "

// Разбить на массив
"яблоки,груши,бананы".split(','); // ['яблоки', 'груши', 'бананы']

// Получить первую букву
const firstLetter = text.trim()[0]; // "М"
```

---

### 4. Работа с localStorage

```javascript
// Сохранить простое значение
localStorage.setItem('username', 'Иван');

// Получить значение
const username = localStorage.getItem('username');
console.log(username); // "Иван"

// Сохранить объект (нужно превратить в строку)
const user = { name: 'Иван', age: 25 };
localStorage.setItem('user', JSON.stringify(user));

// Получить объект (нужно распарсить)
const savedUser = JSON.parse(localStorage.getItem('user'));
console.log(savedUser.name); // "Иван"

// Удалить
localStorage.removeItem('username');

// Удалить всё
localStorage.clear();

// Проверить есть ли значение
if (localStorage.getItem('theme')) {
    console.log('Тема сохранена');
}

// Безопасное получение с дефолтом
function getWithDefault(key, defaultValue) {
    const saved = localStorage.getItem(key);
    return saved !== null ? saved : defaultValue;
}

const theme = getWithDefault('theme', 'light');
```

---

### 5. События и DOM

```javascript
// Найти элемент
const button = document.getElementById('myButton');
const input = document.querySelector('.my-input');
const allButtons = document.querySelectorAll('button');

// Клик
button.addEventListener('click', function() {
    console.log('Кликнули!');
});

// Клик с стрелочной функцией
button.addEventListener('click', () => {
    console.log('Кликнули!');
});

// Получить значение из input
input.addEventListener('input', (e) => {
    console.log('Текущее значение:', e.target.value);
});

// Enter в input
input.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        console.log('Нажали Enter!');
    }
});

// Создать элемент
const div = document.createElement('div');
div.className = 'my-class';
div.textContent = 'Привет!';
document.body.appendChild(div);

// Удалить элемент
div.remove();

// Изменить HTML внутри
div.innerHTML = '<strong>Жирный текст</strong>';

// Изменить только текст (безопаснее)
div.textContent = 'Просто текст';

// Добавить/убрать класс
div.classList.add('active');
div.classList.remove('active');
div.classList.toggle('active'); // Если есть - убрать, если нет - добавить

// Проверить наличие класса
if (div.classList.contains('active')) {
    console.log('Активен!');
}

// Изменить стиль
div.style.color = 'red';
div.style.backgroundColor = '#f0f0f0';
```

---

## CSS трюки

### 1. Центрирование

```css
/* Центрирование с Flexbox */
.container {
    display: flex;
    justify-content: center; /* По горизонтали */
    align-items: center;     /* По вертикали */
    height: 100vh;
}

/* Центрирование блока */
.box {
    width: 300px;
    margin: 0 auto; /* Центр по горизонтали */
}

/* Абсолютное центрирование */
.absolute-center {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
```

---

### 2. Анимации

```css
/* Плавный переход */
.button {
    background: blue;
    transition: all 0.3s ease;
}

.button:hover {
    background: darkblue;
    transform: scale(1.1); /* Увеличение на 10% */
}

/* Анимация появления */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.item {
    animation: fadeIn 0.5s ease;
}

/* Пульсация */
@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

.notification {
    animation: pulse 2s infinite;
}
```

---

### 3. Градиенты

```css
/* Линейный градиент */
.gradient-1 {
    background: linear-gradient(to right, #ff6b6b, #4ecdc4);
}

/* Диагональный */
.gradient-2 {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Три цвета */
.gradient-3 {
    background: linear-gradient(to bottom, #ff6b6b, #feca57, #48dbfb);
}

/* Радиальный */
.radial {
    background: radial-gradient(circle, #ff6b6b, #4ecdc4);
}

/* Градиент текста */
.gradient-text {
    background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
```

---

### 4. Тени

```css
/* Тень блока */
.box-shadow {
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Большая тень */
.big-shadow {
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
}

/* Внутренняя тень */
.inset-shadow {
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Тень текста */
.text-shadow {
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

/* Светящийся эффект */
.glow {
    box-shadow: 0 0 20px rgba(102, 126, 234, 0.6);
}
```

---

### 5. Адаптивность

```css
/* Мобильные устройства (до 768px) */
@media (max-width: 768px) {
    .container {
        padding: 10px;
    }

    h1 {
        font-size: 1.5rem;
    }

    .button {
        width: 100%;
    }
}

/* Планшеты (768px - 1024px) */
@media (min-width: 768px) and (max-width: 1024px) {
    .container {
        padding: 20px;
    }
}

/* Десктоп (больше 1024px) */
@media (min-width: 1024px) {
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
}
```

---

## Готовые функции

### 1. Валидация формы

```javascript
function validateForm(formData) {
    const errors = [];

    // Проверка email
    if (!formData.email.includes('@')) {
        errors.push('Неверный формат email');
    }

    // Проверка длины пароля
    if (formData.password.length < 6) {
        errors.push('Пароль должен быть минимум 6 символов');
    }

    // Проверка на пустоту
    if (!formData.name.trim()) {
        errors.push('Имя не может быть пустым');
    }

    return {
        valid: errors.length === 0,
        errors: errors
    };
}

// Использование
const result = validateForm({
    email: 'test@mail.ru',
    password: '123456',
    name: 'Иван'
});

if (result.valid) {
    console.log('Форма валидна!');
} else {
    console.log('Ошибки:', result.errors);
}
```

---

### 2. Дебаунс (задержка выполнения)

```javascript
function debounce(func, delay) {
    let timeout;
    return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), delay);
    };
}

// Использование: поиск с задержкой
const searchInput = document.getElementById('search');

const performSearch = debounce((query) => {
    console.log('Ищем:', query);
    // Здесь запрос к API
}, 300); // Подождать 300мс после последнего ввода

searchInput.addEventListener('input', (e) => {
    performSearch(e.target.value);
});
```

---

### 3. Форматирование чисел

```javascript
// Разделитель тысяч
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
}

formatNumber(1234567); // "1 234 567"

// Цена
function formatPrice(price) {
    return formatNumber(price) + ' ₽';
}

formatPrice(1234.50); // "1 234.5 ₽"

// Округление
function roundTo(num, decimals) {
    return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);
}

roundTo(3.14159, 2); // 3.14
```

---

### 4. Генератор ID

```javascript
// Простой ID
function generateId() {
    return Date.now() + Math.random().toString(36).substr(2, 9);
}

generateId(); // "1698234567890abc123"

// UUID v4 (более надёжный)
function generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        const r = Math.random() * 16 | 0;
        const v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

generateUUID(); // "550e8400-e29b-41d4-a716-446655440000"
```

---

### 5. Копирование в буфер обмена

```javascript
async function copyToClipboard(text) {
    try {
        await navigator.clipboard.writeText(text);
        console.log('Скопировано!');
        return true;
    } catch (err) {
        console.error('Ошибка копирования:', err);
        return false;
    }
}

// Использование
const copyButton = document.getElementById('copy');
copyButton.addEventListener('click', async () => {
    const success = await copyToClipboard('Текст для копирования');
    if (success) {
        copyButton.textContent = '✓ Скопировано!';
        setTimeout(() => {
            copyButton.textContent = 'Копировать';
        }, 2000);
    }
});
```

---

### 6. Уведомления

```javascript
class Notification {
    constructor() {
        this.container = this.createContainer();
    }

    createContainer() {
        const container = document.createElement('div');
        container.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        `;
        document.body.appendChild(container);
        return container;
    }

    show(message, type = 'info') {
        const notification = document.createElement('div');
        notification.textContent = message;
        notification.style.cssText = `
            padding: 15px 20px;
            margin-bottom: 10px;
            border-radius: 8px;
            color: white;
            background: ${type === 'success' ? '#27ae60' : type === 'error' ? '#e74c3c' : '#3498db'};
            animation: slideIn 0.3s ease;
        `;

        this.container.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }
}

// CSS анимации добавить в style.css
/*
@keyframes slideIn {
    from {
        transform: translateX(400px);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

@keyframes slideOut {
    from {
        transform: translateX(0);
        opacity: 1;
    }
    to {
        transform: translateX(400px);
        opacity: 0;
    }
}
*/

// Использование
const notify = new Notification();
notify.show('Товар добавлен!', 'success');
notify.show('Ошибка!', 'error');
notify.show('Информация', 'info');
```

---

## 🎯 Практические задачи

Попробуйте использовать эти примеры в вашем проекте:

1. **Добавьте уведомления** при добавлении/удалении товара
2. **Добавьте счётчик** количества каждого товара
3. **Сделайте поиск** с debounce
4. **Добавьте дату создания** товара
5. **Кнопку копирования** списка в буфер обмена

---

**Удачи в экспериментах! 🚀**
