select * From "Album"
order by "ArtistId" ASC;

select * From "Employee"
where "City"='Calgary';

-- ORDER BY
-- Order by ile gelen kayıtlar arasında firstname sutünuna göre a'dan z'ye gelen kayıtları listeler. Tam tersi sıralama şekline Descending
-- denir ve desc olarak yazılır.
select DISTINCT "FirstName" || ' ' || "LastName" Full_name, "Title"
From "Employee" order by  "FirstName" asc ;

select "Name","Composer" From "Track"
order by  "Name" asc , "Composer" desc;

-- DISTINCT
-- distinct gelen kayıtları tekilleştirir.
select DISTINCT "FirstName" from "Customer"
order by "FirstName" asc;

-- GROUP BY

select "Title",count("Title") From "Employee"
group by ("Title") order by count("Title") desc;

-- Track tablosundan Composer ve Millisecond sütunlarını getir ancak milisecond < 100000 ve composer not null olan kayıtları.
SELECT "Composer","Milliseconds" FROM "Track"
WHERE "Milliseconds" < 100000 and "Composer" is not null
ORDER BY  "Composer" ASC;

-- Track tablosundan mediatypeid'si 1 e eşit olmayan kayıtları getir. Ancak burada != operatörü de kullanılabilir.
SELECT * FROM "Track"
WHERE "MediaTypeId" <> 1;

-- Büyük küçük harfe dikkat ederek Track tablosu içerisinden composer sütununda a ile başlayan kayıtları getirir.
SELECT "Composer","Milliseconds","Bytes","UnitPrice" FROM "Track"
WHERE "Composer" LIKE 'a%';

-- Üstteki sorgudan farkı büyük ve küçük harf hassasiyeti olmadan araması
SELECT "Composer","Milliseconds","Bytes","UnitPrice" FROM "Track"
WHERE "Composer" ILIKE 'a%';

-- Büyük küçük harfe dikkat ederek Track tablosu içerisinden composer sütununda sonu "ild" ile biten kayıtları getirir.
SELECT "Composer","Milliseconds","Bytes","UnitPrice" FROM "Track"
WHERE "Composer" LIKE '%ild';

-- Büyük küçük harfe dikkat ederek Track tablosu içerisinden composer sütununda sonu 5 harfli bir kelimenin sonu c ile biten kayıtları getirir.
SELECT * FROM "Track"
WHERE "Composer" LIKE '____C%';

-- Büyük küçük harfe dikkat ederek Track tablosu içerisindeki composer sütununda 2. ve üçüncü harfi ng olan bütün kayıtları getir.
SELECT * FROM "Track"
WHERE "Composer" LIKE '_ng__%';

-- Baş harfi son harfi ve uzunluğu verilen kayıtları getir.
SELECT * FROM "Track"
WHERE "Composer" ILIKE 'C___________e';

--Concat (Birleştirme)
-- metin birleştirme işlemlerinde concat kullanılması çok daha iyidir Sebepleri:
-- 1- bir metin ile null toplanırsa sonuç metindir.
-- 2- bir metin ile int değer toplanabilir.

select "CustomerId",concat("FirstName",' ',"LastName") as full_name From "Customer"
order by "CustomerId" asc;

select "FirstName",concat('Adınız ',length("FirstName"),' karakter içeriyor.') AS uzunluk From "Customer";

--Concat_ws (Concat with a seperator)
-- iki veri arasına aldığı ilk parametreyi vererek birleştirme işlemini yapar.
select  concat_ws(',',"FirstName","LastName") as full_name
from "Customer" order by "FirstName" asc;

-- Mantıksal Operatörler
-- AND, OR , NOT , Between ,
-- Birden fazla where kısıtlama ifadesi eklenebilir.
select "BillingAddress", "BillingCity","BillingPostalCode","Total"
from "Invoice"
where "Total" < 2.00 and "BillingAddress" Ilike 'c%' and "BillingCity" not like '%o';

select * from "Invoice"
WHERE "Total" between 2 and 3;

-- BillingCity sütununda t ile biten veya Total sütunundaki 2 ile 3 arasındaki tüm kayıtları getir.
select * from "Invoice"
where  "BillingCity" ILIKE '%t' or "Total" between 2 and 3;

-- total sütununda 2 ile 9 arasında olmayan tüm kayıtları getir.
select * from "Invoice"
where "Total" not between 2 and 9;

-- LIMIT ve OFFSET

select * from "Invoice" LIMIT 2;

select * from "Invoice" LIMIT 2 offset 1;

-- UNION ve UNION ALL

-- iki sorgudan gelen kayıtları unique yaparak birleştirir.
select "ArtistId" From "Artist"
union
select "ArtistId" From "Album";

--  iki sorgudan gelen kayıtların hepsini birleştirir.
select "ArtistId" From "Artist"
union all
select "ArtistId" From "Album";


