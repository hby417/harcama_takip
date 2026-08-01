USE HARCAMATAKİP
GO
CREATE TABLE kategoriler( 
                          kategoriID INT IDENTITY(1,1)   PRIMARY KEY NOT NULL,
                          kategoriAdi NVARCHAR(50) NOT NULL
);

GO

INSERT INTO kategoriler (kategoriAdi) VALUES ('Sağlık') 
SELECT * FROM kategoriler

USE HARCAMATAKİP
GO
CREATE TABLE harcamalar(
harcamaID INT PRIMARY KEY IDENTITY(1,1),
kategoriID INT FOREIGN KEY REFERENCES kategoriler(kategoriID),
harcamaTarihi DATE NOT NULL,
tutar DECIMAL(10,2) NOT NULL,	
odemeTipi VARCHAR(10) CHECK (odemeTipi IN ('Kart', 'Nakit')),
);

	
EXEC sp_help 'harcamalar'           --ALIŞKANLIK OLMASI İÇİN HER TABLO SONRASI KONTROL ETTİM

DELETE FROM kategoriler             --AYNI İSİMDE İKİ KATEGORİ ADI OLUŞTUĞU İÇİN ÖNCE BİRİNİ SİLDİM SONRA UQ EKLEDİM
WHERE kategoriID=2

ALTER TABLE kategoriler
ADD CONSTRAINT UQ_kategoriler_kategoriAdi  UNIQUE (kategoriAdi);

INSERT INTO kategoriler(kategoriAdi) VALUES ('Market'), ('Ulaşım'), ('Eğlence'), ('Diğer')
SELECT *FROM kategoriler

INSERT INTO harcamalar (kategoriID, harcamaTarihi, tutar, odemeTipi)
VALUES (6, '2026-07-23', 300, 'Nakit');


SELECT *FROM harcamalar

SELECT h.tutar, h.harcamaTarihi, k.kategoriAdi
FROM harcamalar AS h
INNER JOIN kategoriler AS k ON h.kategoriID = k.kategoriID;


SELECT SUM(h.tutar) AS ToplamHarcama
FROM harcamalar AS h
WHERE  YEAR(h.harcamaTarihi) = 2026 AND MONTH(h.harcamaTarihi) = 7               --2026 TEMMUZDAKİ TOPLAM HARCAMA



SELECT k.kategoriAdi, SUM(h.tutar) AS ToplamHarcama
FROM harcamalar AS h
INNER JOIN kategoriler AS k ON h.kategoriID = k.kategoriID   
WHERE  YEAR(h.harcamaTarihi) = 2026 AND MONTH(h.harcamaTarihi) = 7         -- 2026 TEMMUZDAKİ HARCAMALARIN KATEGORİSEL AYRIMI 
GROUP BY k.kategoriAdi
ORDER BY toplamHarcama DESC



