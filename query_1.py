import sqlite3


def execute_query():
    # читаємо файл зі скриптом для запиту
    with open('query_12.sql', 'r') as f:
        sql = f.read()

    # створюємо з'єднання з БД (якщо файлу з БД немає, він буде створений)
    with sqlite3.connect('hw6.sqlite') as con:
        cur = con.cursor()
        # виконуємо запит із файлу, який створить таблиці в БД
        cur.execute(sql)
        print(cur.fetchall())


if __name__ == "__main__":
    execute_query()
