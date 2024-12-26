CREATE DATABASE IF NOT EXISTS KlinikYonetimi;
USE KlinikYonetimi;

CREATE TABLE IF NOT EXISTS Hastalar (
    HastaID INT AUTO_INCREMENT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    DogumTarihi DATE,
    Telefon VARCHAR(15),
    Email VARCHAR(100),
    Adres TEXT,
    Cinsiyet ENUM('Erkek', 'Kadın'),
    KanGrubu ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', '0+', '0-'),
    KayitTarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Doktorlar (
    DoktorID INT AUTO_INCREMENT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    UzmanlikAlani VARCHAR(100),
    Telefon VARCHAR(15),
    Email VARCHAR(100),
    CalismaSaatleri VARCHAR(50),
    Maas DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Randevular (
    RandevuID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    DoktorID INT,
    RandevuTarihi DATETIME,
    Sikayet TEXT,
    Ucret DECIMAL(10, 2),
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (DoktorID) REFERENCES Doktorlar(DoktorID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Hizmetler (
    HizmetID INT AUTO_INCREMENT PRIMARY KEY,
    HizmetAdi VARCHAR(100),
    Aciklama TEXT,
    Fiyat DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Ilaclar (
    IlacID INT AUTO_INCREMENT PRIMARY KEY,
    IlacAdi VARCHAR(100),
    EtkenMadde VARCHAR(100),
    Fiyat DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Receteler (
    ReceteID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    DoktorID INT,
    Tarih DATE,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (DoktorID) REFERENCES Doktorlar(DoktorID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ReceteDetay (
    ReceteDetayID INT AUTO_INCREMENT PRIMARY KEY,
    ReceteID INT,
    IlacID INT,
    Miktar INT,
    FOREIGN KEY (ReceteID) REFERENCES Receteler(ReceteID) ON DELETE CASCADE,
    FOREIGN KEY (IlacID) REFERENCES Ilaclar(IlacID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Odalar (
    OdaID INT AUTO_INCREMENT PRIMARY KEY,
    OdaNo INT,
    Kat INT,
    Tip VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS HastaYatis (
    YatisID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    OdaID INT,
    GirisTarihi DATE,
    CikisTarihi DATE,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (OdaID) REFERENCES Odalar(OdaID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Sigortalar (
    SigortaID INT AUTO_INCREMENT PRIMARY KEY,
    SigortaAdi VARCHAR(100),
    Kapsam TEXT
);

CREATE TABLE IF NOT EXISTS HastaSigorta (
    HastaSigortaID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    SigortaID INT,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (SigortaID) REFERENCES Sigortalar(SigortaID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Laboratuvarlar (
    LaboratuvarID INT AUTO_INCREMENT PRIMARY KEY,
    LaboratuvarAdi VARCHAR(100),
    Konum TEXT
);

CREATE TABLE IF NOT EXISTS Testler (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    TestAdi VARCHAR(100),
    Fiyat DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS HastaTest (
    HastaTestID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    TestID INT,
    Tarih DATE,
    Sonuc TEXT,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (TestID) REFERENCES Testler(TestID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS TibbiEkipmanlar (
    EkipmanID INT AUTO_INCREMENT PRIMARY KEY,
    EkipmanAdi VARCHAR(100),
    Durum ENUM('Kullanımda', 'Bakımda', 'Depoda')
);

CREATE TABLE IF NOT EXISTS Calisanlar (
    CalisanID INT AUTO_INCREMENT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Departman VARCHAR(100),
    Telefon VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Maaslar (
    MaasID INT AUTO_INCREMENT PRIMARY KEY,
    CalisanID INT,
    MaasTarihi DATE,
    Tutar DECIMAL(10, 2),
    FOREIGN KEY (CalisanID) REFERENCES Calisanlar(CalisanID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Kullanicilar (
    KullaniciID INT AUTO_INCREMENT PRIMARY KEY,
    KullaniciAdi VARCHAR(50),
    Sifre VARCHAR(100),
    Rol ENUM('Admin', 'Doktor', 'Sekreter')
);

CREATE TABLE IF NOT EXISTS Tedarikciler (
    TedarikciID INT AUTO_INCREMENT PRIMARY KEY,
    TedarikciAdi VARCHAR(100),
    Telefon VARCHAR(15),
    Email VARCHAR(100),
    Adres TEXT
);

CREATE TABLE IF NOT EXISTS TedarikEdilenUrunler (
    UrunID INT AUTO_INCREMENT PRIMARY KEY,
    TedarikciID INT,
    UrunAdi VARCHAR(100),
    Miktar INT,
    TeslimTarihi DATE,
    FOREIGN KEY (TedarikciID) REFERENCES Tedarikciler(TedarikciID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS HastaNotlari (
    NotID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    DoktorID INT,
    NotTarihi DATE,
    NotMetni TEXT,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE,
    FOREIGN KEY (DoktorID) REFERENCES Doktorlar(DoktorID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Egitimler (
    EgitimID INT AUTO_INCREMENT PRIMARY KEY,
    CalisanID INT,
    EgitimAdi VARCHAR(100),
    Tarih DATE,
    FOREIGN KEY (CalisanID) REFERENCES Calisanlar(CalisanID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FinansalIslemler (
    IslemID INT AUTO_INCREMENT PRIMARY KEY,
    HastaID INT,
    Tutar DECIMAL(10, 2),
    IslemTarihi DATE,
    Aciklama TEXT,
    FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Araclar (
    AracID INT AUTO_INCREMENT PRIMARY KEY,
    Plaka VARCHAR(20),
    Marka VARCHAR(50),
    Model VARCHAR(50),
    Durum ENUM('Aktif', 'Bakımda')
);
