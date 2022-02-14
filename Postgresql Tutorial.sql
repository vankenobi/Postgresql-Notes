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
-- distinct gelen kayıtları tekilleştirir. Unique hale getirir.
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

-- Concat_ws (Concat with a seperator)
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

-----------------------------------------------------
-----------  Create, Alter, Drop --------------------
-----------------------------------------------------

-- sampleDatabase1 adlı bir database oluşturmak için aşağıdaki kod çalıştırılır.
Create DATABASE sampleDatabase1;

-- Create Table
Create TABLE companies
(
    ID INT,
    NAME char(60),
    AGE INT,
    ADDRESS char(50),
    Price REAL
);

Create Table depatmant
(
    ID int,
    name char(60),
    description char(200)
);

Create table employes
(
    ID INTEGER,
    NAME char varying(60),
    BIRTHDATE date,
    IsCurrentEmployee bit(1)
);

Create table customers
(
    NAME char varying(60),
    BIRTHDATE date,
    ZipCode char(50)
);

-- Invoice tablosunun içerisinde BillingCity sütununda a ile başlayan kayıtları getirerek bu kayıtlardan adı table_from_query olan
-- bir tablo oluştur.
Create table table_from_query as (select * from "Invoice" where "BillingCity" Ilike 'a%') with data;

-- Yukarıdaki tablo aynı tablo yapısını data olmadan oluşturur çünkü sorgu sonunda with no data ibaresi mevcuttur.
Create table table_from_query_2 as (select  * from "Invoice" where "BillingCity" ILIKE  'a%') with no data;

-- Serial tipi otomatik artan demektir. Id gibi primary key alanlarda kullanılır.
Create Table company
(
    ID serial,
    name char(60),
    description char(200)
);

insert into company(name, description) values ('Beko','Bir beyaz eşya mağazasıdır.');
insert into company(name, description) values ('Arçelik','Bir beyaz eşya mağazasıdır.');

-- Son oluşturulan id'yi verir.
select currval(pg_get_serial_sequence('company','id'));

select * from company;

SELECT * From companies;

-- Drop silme işlemi yapmak için kullanılır.
Drop table company;

-- Sequence
-- bir unique otomatik artan anahtar oluştururken kullanılır.
CREATE SEQUENCE demotable_id_seq;

CREATE TABLE Deneme
(
    id integer default nextval('demotable_id_seq'),
    name char(50)
);

insert into deneme(name) values('nursena');

select * from deneme;

-- Geçici Tablo Oluşturmak

-- Select Into ile
-- Üzerinde çalışacağımız bir veri seti yaratmak istediğimizde ve ana tabloyu meşgul etmek istemediğimizde kullanılabilir.
-- Oturum kapandığı zaman bu geçici tablolar silinecektir ve bunlar diskte tutulmaz.
select "FirstName","LastName","Address"
Into Table customer_backup
from "Customer"
Where "FirstName" ILIKE 'f%'
order by  "LastName" asc;

-- Select into temp ile
select "BillingCity","BillingAddress","Total"
into temp table invoice_backup
from "Invoice"
where "Total" > 10 and "BillingCity" ILIKE 'a%'
order by "BillingCity" asc ;

-- Create Temp Table ile
-- Bu geçici tablonun yukarıdaki ikisinden farkı fiziksel tablo gibi olması.
-- Aynı isimde bir gerçek bir de geçici tablo oluşturulabilir fakat önerilmez.
-- Aynı isimde bir gerçek bir de geçici tablo oluşturduğumuz zaman aksiyonlar geçici tablo üzerinden akar örneğin bir kayıt
-- eklediğimizde geçici tabloya eklenir veya sildiğimizde geçici tablodan silinir. Tabloyu tamamen silmek istediğimiz zaman
-- geçici tablo silinir. Örneği aşağıdaki sql sorgularında mevcuttur.

Create Table test1
(
  id serial,
  ad varchar,
  soyad varchar
);

Create Temp Table test1
(
 id serial,
 ad varchar,
 soyad varchar
);

insert into test1(ad,soyad) values('musa','kucuk');
drop table test1;
select * from test1;

-- ALTER

Create Table test1
(
  id serial,
  ad varchar,
  soyad varchar
);

Alter table test1 add gender varchar; --tabloya gender adında yeni bir sütun eklendi.
select * from test1;
Alter table test1 drop gender; -- toblodan gender adında sütun silindi.
select * from test1;
Alter table test1 rename to test_bir; -- tablonun adı test_bir olarak değiştirildi.
select * from test_bir;
Alter table test_bir rename column ad to first_name; -- tablo içerisinde bir sütunun adını değiştirmek için kullanılır.
select * from test_bir;
Alter table test_bir add column tc_no char(11) not null;
insert into test_bir(first_name, soyad, tc_no) values('musa','kucuk','513333263');

-- Drop Table

Drop table test_bir;
Drop table test_bir,deneme;
Drop table if exists olmayan_bir_tablo; -- Eğer tablo var ise siler. Daha sağlıklı bir sorgudur. Çünkü olmayan tabloyu silmekten
                                        -- çıkan hataların önüne geçer.
Create DATABASE silmek_icin;
Drop database if exists silmek_icin;

-- Select, Insert, Update, Delete

Create table if not exists mahkumlar
(
    id serial,
    name varchar,
    surname varchar
);

insert into mahkumlar(name, surname) values('musa','kucuk'),('ali','urban'); -- Birden fazla insert işlemi yapmak için kullanılır.
select * from mahkumlar;

Update mahkumlar SET name = 'Hayri' Where name = 'musa';
Update mahkumlar Set name = 'mandaline' Where name = 'nursena';
select  * from mahkumlar_backup;

Delete from mahkumlar_backup; -- Where anahtar sözcüğü olmadan bu sorgu tavsiye edilmez.
Delete from mahkumlar_backup where id=1;

-- Check constraint

Create table if not exists countries
(
    country_id  varchar(2),
    country_name varchar(40) check (country_name notnull),
    region_id int
);

insert into countries(country_id, country_name, region_id) values('TR',null,22); -- country_name sütunu null olamaz.

-- Numeric constraint

Create Table If NOT EXISTS vatandaslar
(
    TC_NO    varchar primary key check ( length(TC_NO) = 11 ),
    Ad       varchar,
    Soyad    varchar,
    Cinsiyet bit
);

Alter table vatandaslar alter column tc_no type varchar;
insert into vatandaslar(TC_NO, Ad, Soyad) values('12345678900','Erhan','Taş');
insert into vatandaslar(TC_NO, Ad, Soyad) values('1234567890','Erol','Taş'); -- bu kayıt gerçekleşmeyecektir çünkü tc kimlik no 11 karakter değildir.
select * from vatandaslar;

