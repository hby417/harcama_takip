import pyodbc

baglanti = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost\\SQLEXPRESS01;"
    "DATABASE=HARCAMATAKİP;"
    "Trusted_Connection=yes;"
)
print("Veritabanına bağlantı başarılı!")

cursor = baglanti.cursor()

cursor.execute("SELECT kategoriID, kategoriAdi FROM kategoriler")

satirlar = cursor.fetchall()

for satir in satirlar:
    print(satir[0], "-", satir[1])