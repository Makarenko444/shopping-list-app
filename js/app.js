// Список покупок - простое веб-приложение
class ShoppingApp {
    constructor() {
        this.items = this.loadItems();
        this.initElements();
        this.attachEvents();
        this.render();
    }

    // Находим элементы на странице
    initElements() {
        this.itemInput = document.getElementById('itemInput');
        this.addBtn = document.getElementById('addBtn');
        this.shoppingList = document.getElementById('shoppingList');
        this.totalItems = document.getElementById('totalItems');
    }

    // Навешиваем обработчики событий
    attachEvents() {
        this.addBtn.addEventListener('click', () => this.addItem());
        this.itemInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                this.addItem();
            }
        });
    }

    // Добавить новый товар
    addItem() {
        const text = this.itemInput.value.trim();
        
        if (text === '') {
            alert('Введите название товара!');
            return;
        }

        const newItem = {
            id: Date.now(), // простой ID на основе времени
            text: text,
            completed: false,
            createdAt: new Date().toLocaleDateString('ru-RU')
        };

        this.items.push(newItem);
        this.itemInput.value = '';
        this.saveItems();
        this.render();
    }

    // Переключить статус товара (куплен/не куплен)
    toggleItem(id) {
        const item = this.items.find(item => item.id === id);
        if (item) {
            item.completed = !item.completed;
            this.saveItems();
            this.render();
        }
    }

    // Удалить товар
    deleteItem(id) {
        this.items = this.items.filter(item => item.id !== id);
        this.saveItems();
        this.render();
    }

    // Отрисовать весь список
    render() {
        this.shoppingList.innerHTML = '';
        
        this.items.forEach(item => {
            const li = document.createElement('li');
            li.className = `shopping-item ${item.completed ? 'completed' : ''}`;
            
            li.innerHTML = `
                <input type="checkbox" 
                       class="item-checkbox" 
                       ${item.completed ? 'checked' : ''}
                       onchange="app.toggleItem(${item.id})">
                <span class="item-text">${item.text}</span>
                <button class="delete-btn" onclick="app.deleteItem(${item.id})">
                    🗑️
                </button>
            `;
            
            this.shoppingList.appendChild(li);
        });

        this.updateStats();
    }

    // Обновить статистику
    updateStats() {
        const total = this.items.length;
        const completed = this.items.filter(item => item.completed).length;
        this.totalItems.textContent = `Всего товаров: ${total} (куплено: ${completed})`;
    }

    // Сохранить в localStorage
    saveItems() {
        localStorage.setItem('shoppingItems', JSON.stringify(this.items));
    }

    // Загрузить из localStorage
    loadItems() {
        const saved = localStorage.getItem('shoppingItems');
        return saved ? JSON.parse(saved) : [];
    }
}

// Запускаем приложение когда страница загружена
document.addEventListener('DOMContentLoaded', () => {
    window.app = new ShoppingApp();
});

// Простая функция для очистки всего списка
function clearAllItems() {
    if (confirm('Удалить все товары?')) {
        app.items = [];
        app.saveItems();
        app.render();
    }
}
