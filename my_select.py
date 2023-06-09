import sqlite3

from prettytable import from_db_cursor

def select(i):
    # читаємо файл зі скриптом для запиту
    with open(f'query_{i}.sql', 'r') as f:
        sql = f.read()
    
    # створюємо з'єднання з БД 
    with sqlite3.connect('hw6.sqlite') as con:
        cur = con.cursor()
        # виконуємо запит із файлу
        cur.execute(sql)
        return cur

query_table = [
    "Виберіть який запит ви хочете виконати?",
    "1 -- Знайти 5 студентів із найбільшим середнім балом з усіх предметів.",
    "2 -- Знайти студента із найвищим середнім балом з певного предмета.",
    "3 -- Знайти середній бал у групах з певного предмета.",
    "4 -- Знайти середній бал на потоці (по всій таблиці оцінок).",
    "5 -- Знайти які курси читає певний викладач.",
    "6 -- Знайти список студентів у певній групі.",
    "7 -- Знайти оцінки студентів у окремій групі з певного предмета.",
    "8 -- Знайти середній бал, який ставить певний викладач зі своїх предметів.",
    "9 -- Знайти список курсів, які відвідує студент.",
    "10 -- Список курсів, які певному студенту читає певний викладач.",
    "11 -- Середній бал, який певний викладач ставить певному студентові.",
    "12 -- Оцінки студентів у певній групі з певного предмета на останньому занятті.",
    "Будь яке інше число -- Вихід"
]
tooltip = '\n'
for s in query_table:
    tooltip = tooltip + s + '\n'

if __name__ == "__main__":
    print(tooltip)
    while True:
        try:
            query = int(input("Виберіть номер запиту: "))
            if 1 <= query <= 12:
                result = select(query)
            else:
                break
            print(query_table[query])
            print(from_db_cursor(result))
            print()
        except:
            print('Input number, please!')
        
    print('Finish query')
    