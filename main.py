import sqlite3
from datetime import datetime

db_file = r'C:\Users\Administrator\Documents\VSCode\Final Project Database\ecommerce.db'

def show_purchases_over_100(connection):
    print("\nCustomers who bought products priced over $100:\n")
    query = """
    SELECT
      c.name customer_name,
      p.name product_name,
      p.price
    FROM
      Purchase pu
    JOIN
      Customer c ON pu.customer_id = c.customer_id
    JOIN
      Product p ON pu.product_id = p.product_id
    WHERE
      p.price > 100;
    """
    result = connection.execute(query)
    rows = result.fetchall()
    for row in rows:
        print(f"Customer: {row[0]}, Product: {row[1]}, Price: ${row[2]:.2f}")

def add_purchase(connection):
    print("\nAdd a new purchase:")
    customer_id = input("Enter customer_id: ")
    product_id = input("Enter product_id: ")
    staff_id = input("Enter staff_id: ")
    purchase_date = datetime.now().date().isoformat()

    result = connection.execute("SELECT MAX(purchase_id) FROM Purchase")
    max_id = result.fetchone()[0]
    if max_id is None:
        purchase_id = 1
    else:
        purchase_id = max_id + 1

    insert_sql = """
    INSERT INTO Purchase (purchase_id, customer_id, product_id, staff_id, purchase_date)
    VALUES (?, ?, ?, ?, ?)
    """
    try:
        connection.execute(insert_sql, (purchase_id, customer_id, product_id, staff_id, purchase_date))
        connection.commit()
        print(f"Purchase added with ID {purchase_id} on {purchase_date}")
    except Exception as e:
        print("Error inserting purchase:", e)

def main():
    connection = sqlite3.connect(db_file)
    print("Database connection established.")

    while True:
        print("\nOptions:")
        print("1. Show purchases with products priced over $100")
        print("2. Add a new purchase")
        print("3. Exit")

        choice = input("Choose an option: ")

        if choice == '1':
            show_purchases_over_100(connection)
        elif choice == '2':
            add_purchase(connection)
        elif choice == '3':
            break
        else:
            print("Invalid option. Please try again.")

    connection.close()

if __name__ == '__main__':
    main()
