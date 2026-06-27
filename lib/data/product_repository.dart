class ProductRepository {
  static const String imgCpu = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHMNZjbSIorUX9H14KO8GRrbvsI4797sKllmSfPI_hevDgcPISpVuZ5BM&s=10';
  static const String imgMotherboard = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg5f9eaLD6-RiZUuOFTsXoIE1hdM2Tb04UOkdNPX6VgVBf1Z7Hzxw41o16&s=10';
  static const String imgRam = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEF9Dit6kQkhucb8R-eQ2qWmZ_aOItm2LR6yBYRVpTsx77yRCHFB540k1N&s=10';
  static const String imgGpu = 'https://i.ebayimg.com/images/g/VmsAAOSwfrlnx8pF/s-l400.jpg';
  static const String imgStorage = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU274yVum1QqcAortlmLHIO6EWcELFa3vx9iayO3f8uQ&s=10';
  static const String imgPsu = 'https://c8.alamy.com/comp/G29229/pc-power-supply-isolated-G29229.jpg';
  static const String imgCase = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1658EwibLcEZYgNBeY5OoVW1-hyDyDifVz4r3IMCTNlqaTumyqazJbe43&s=10';

  static final List<Map<String, dynamic>> _cpus = [
    {'name': 'AMD Ryzen 9 7950X', 'price': 699, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'AM5', 'tdp': 170},
    {'name': 'AMD Ryzen 7 7800X3D', 'price': 380, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'AM5', 'tdp': 120},
    {'name': 'AMD Ryzen 5 7600X', 'price': 229, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'AM5', 'tdp': 105},
    {'name': 'AMD Ryzen 5 7600', 'price': 220, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'AM5', 'tdp': 65},
    {'name': 'Intel Core i9-13900K', 'price': 589, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i7-13700K', 'price': 420, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i5-13600K', 'price': 319, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i5-12400F', 'price': 179, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 65},
    {'name': 'AMD Ryzen 7 7700X', 'price': 349, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'AM5', 'tdp': 105},
    {'name': 'Intel Core i3-13100', 'price': 119, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 3, 'socket': 'LGA1700', 'tdp': 60},
    {'name': 'AMD Ryzen 9 7900X', 'price': 549, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'AM5', 'tdp': 170},
    {'name': 'AMD Ryzen 5 5600X', 'price': 159, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'AM4', 'tdp': 65},
    {'name': 'Intel Core i9-14900K', 'price': 689, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i7-14700K', 'price': 489, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'Intel Core i5-14600K', 'price': 359, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'AMD Ryzen Threadripper 7960X', 'price': 1499, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 5, 'socket': 'sTR5', 'tdp': 350},
    {'name': 'AMD Ryzen 9 5900X', 'price': 329, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'AM4', 'tdp': 105},
    {'name': 'Intel Core i9-12900K', 'price': 399, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 125},
    {'name': 'AMD Ryzen 7 5700X', 'price': 199, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'AM4', 'tdp': 65},
    {'name': 'Intel Core i5-13400', 'price': 209, 'category': 'CPU', 'imageUrl': imgCpu, 'rating': 4, 'socket': 'LGA1700', 'tdp': 65},
  ];

  static final List<Map<String, dynamic>> _motherboards = [
    {'name': 'MSI MAG B650 Tomahawk', 'price': 190, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'ASUS ROG Strix B650E', 'price': 320, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'AM5'},
    {'name': 'ASUS PRIME X670-P', 'price': 240, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'Gigabyte X670 AORUS Elite', 'price': 260, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'AM5'},
    {'name': 'ASRock B650M Steel Legend', 'price': 150, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'ASUS PRIME Z790-P', 'price': 210, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'LGA1700'},
    {'name': 'MSI PRO Z790-A', 'price': 200, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'LGA1700'},
    {'name': 'Gigabyte Z790 UD AX', 'price': 190, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'LGA1700'},
    {'name': 'ASRock Z790 Phantom Gaming', 'price': 280, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'LGA1700'},
    {'name': 'MSI MAG B660 Tomahawk', 'price': 160, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'LGA1700'},
    {'name': 'ASUS ROG Maximus Z790 Hero', 'price': 629, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'LGA1700'},
    {'name': 'Gigabyte Z790 AORUS Elite AX', 'price': 259, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'LGA1700'},
    {'name': 'MSI MPG Z790 Carbon WiFi', 'price': 379, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'LGA1700'},
    {'name': 'ASRock B650 Pro RS', 'price': 139, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'ASUS TUF Gaming B650-Plus', 'price': 219, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'Gigabyte B650 Gaming X AX', 'price': 189, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM5'},
    {'name': 'MSI MAG X670E Carbon WiFi', 'price': 469, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'AM5'},
    {'name': 'ASUS ROG Crosshair X670E Hero', 'price': 649, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 5, 'socket': 'AM5'},
    {'name': 'ASRock A620M-HDV', 'price': 85, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 3, 'socket': 'AM5'},
    {'name': 'Gigabyte B550 AORUS Elite', 'price': 149, 'category': 'Motherboard', 'imageUrl': imgMotherboard, 'rating': 4, 'socket': 'AM4'},
  ];

  static final List<Map<String, dynamic>> _rams = [
    {'name': 'G.Skill Trident Z5 32GB DDR5', 'price': 90, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'Corsair Vengeance 32GB DDR4', 'price': 75, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'Kingston Fury Beast 32GB DDR5', 'price': 95, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'Crucial Ballistix 16GB DDR4', 'price': 45, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'Corsair Dominator Platinum 32GB DDR5', 'price': 150, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'Team T-Force Delta 32GB DDR5', 'price': 85, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'Patriot Viper 32GB DDR4', 'price': 70, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'Samsung 32GB DDR5 RDIMM', 'price': 130, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'ADATA XPG Lancer 16GB DDR5', 'price': 50, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'Thermaltake TOUGHRAM 32GB DDR4', 'price': 80, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'G.Skill Ripjaws S5 32GB DDR5', 'price': 105, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'Corsair Vengeance RGB 64GB DDR5', 'price': 219, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'Kingston Fury Renegade 32GB DDR5', 'price': 129, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 5, 'type': 'DDR5'},
    {'name': 'G.Skill Flare X5 32GB DDR5', 'price': 99, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'Crucial Pro 32GB DDR5', 'price': 89, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'Team Group Elite 16GB DDR5', 'price': 48, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'Lexar Ares RGB 32GB DDR5', 'price': 115, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR5'},
    {'name': 'ADATA XPG Spectrix 32GB DDR4', 'price': 85, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'PNY XLR8 Gaming 16GB DDR4', 'price': 42, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
    {'name': 'Corsair Vengeance LPX 16GB DDR4', 'price': 39, 'category': 'RAM', 'imageUrl': imgRam, 'rating': 4, 'type': 'DDR4'},
  ];

  static final List<Map<String, dynamic>> _gpus = [
    {'name': 'NVIDIA RTX 4090', 'price': 1599, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 450},
    {'name': 'NVIDIA RTX 4080', 'price': 1199, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 320},
    {'name': 'NVIDIA RTX 4070 Ti Super', 'price': 790, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 285},
    {'name': 'NVIDIA RTX 4070', 'price': 599, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 200},
    {'name': 'NVIDIA RTX 4060 Ti', 'price': 399, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 160},
    {'name': 'NVIDIA RTX 3060', 'price': 330, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 170},
    {'name': 'AMD Radeon RX 7900 XTX', 'price': 999, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 355},
    {'name': 'AMD Radeon RX 7800 XT', 'price': 499, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 300},
    {'name': 'AMD Radeon RX 7700 XT', 'price': 419, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 245},
    {'name': 'Intel Arc A770 16GB', 'price': 329, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 225},
    {'name': 'NVIDIA RTX 4080 Super', 'price': 999, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 320},
    {'name': 'NVIDIA RTX 4070 Super', 'price': 589, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 220},
    {'name': 'AMD Radeon RX 7900 XT', 'price': 749, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 5, 'tdp': 315},
    {'name': 'AMD Radeon RX 7600 XT', 'price': 329, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 190},
    {'name': 'NVIDIA RTX 4060', 'price': 299, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 115},
    {'name': 'Intel Arc A750', 'price': 229, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 225},
    {'name': 'NVIDIA RTX 3070 Ti', 'price': 599, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 290},
    {'name': 'AMD Radeon RX 6700 XT', 'price': 349, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 230},
    {'name': 'NVIDIA GTX 1660 Super', 'price': 199, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 3, 'tdp': 125},
    {'name': 'AMD Radeon RX 6600', 'price': 209, 'category': 'GPU', 'imageUrl': imgGpu, 'rating': 4, 'tdp': 132},
  ];

  static final List<Map<String, dynamic>> _storages = [
    {'name': 'Samsung 990 Pro 2TB NVMe', 'price': 170, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Crucial T700 2TB Gen5 SSD', 'price': 280, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'WD Black SN850X 1TB', 'price': 95, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Crucial P3 Plus 2TB', 'price': 110, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Samsung 870 EVO 1TB SATA', 'price': 80, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Kingston KC3000 2TB', 'price': 140, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Sabrent Rocket 4 Plus 4TB', 'price': 350, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Lexar NM790 2TB NVMe', 'price': 120, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Silicon Power A60 1TB', 'price': 55, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 3},
    {'name': 'Seagate BarraCuda 2TB HDD', 'price': 60, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Samsung 980 Pro 1TB NVMe', 'price': 89, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Crucial T500 2TB NVMe', 'price': 139, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'WD Blue SN580 1TB NVMe', 'price': 64, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Team Group MP44 2TB', 'price': 119, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Solidigm P44 Pro 2TB', 'price': 159, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Samsung T7 Shield 2TB Portable', 'price': 169, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'SanDisk Extreme 1TB SSD', 'price': 99, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'Toshiba X300 8TB HDD', 'price': 199, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 4},
    {'name': 'WD Red Pro 10TB NAS HDD', 'price': 279, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
    {'name': 'Seagate FireCuda 530 1TB', 'price': 119, 'category': 'Storage', 'imageUrl': imgStorage, 'rating': 5},
  ];

  static final List<Map<String, dynamic>> _psus = [
    {'name': 'Corsair RM850x 850W Gold', 'price': 130, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 850},
    {'name': 'EVGA SuperNOVA 1000 G7', 'price': 190, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 1000},
    {'name': 'Seasonic Focus GX-750W', 'price': 115, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 750},
    {'name': 'Thermaltake Toughpower 750W', 'price': 100, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 750},
    {'name': 'be quiet! Straight Power 11', 'price': 140, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 650},
    {'name': 'ASUS ROG Thor 1000W Platinum', 'price': 320, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 1000},
    {'name': 'MSI MAG A750GL 750W Gold', 'price': 90, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 750},
    {'name': 'Cooler Master MWE Gold 850W', 'price': 105, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 850},
    {'name': 'Gigabyte UD850GM 850W', 'price': 95, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 850},
    {'name': 'Corsair SF750 SFX Platinum', 'price': 180, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 750},
    {'name': 'Corsair RM1000x Shift Gold', 'price': 209, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 1000},
    {'name': 'Seasonic Vertex GX-1000W Gen5', 'price': 249, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 1000},
    {'name': 'be quiet! Pure Power 12 M 850W', 'price': 134, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 850},
    {'name': 'Thermaltake Toughpower GF3 1350W', 'price': 229, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 1350},
    {'name': 'Montech Century 650W Gold', 'price': 79, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 650},
    {'name': 'EVGA GE 600W Bronze', 'price': 59, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 3, 'watt': 600},
    {'name': 'SilverStone HELA 2050W Platinum', 'price': 429, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 5, 'watt': 2050},
    {'name': 'Deepcool PX1000G 1000W Gold', 'price': 169, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 1000},
    {'name': 'Super Flower Leadex III 750W', 'price': 109, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 750},
    {'name': 'Apex Gaming 750W Gold', 'price': 89, 'category': 'PSU', 'imageUrl': imgPsu, 'rating': 4, 'watt': 750},
  ];

  static final List<Map<String, dynamic>> _cases = [
    {'name': 'Lian Li O11 Dynamic EVO', 'price': 160, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'NZXT H9 Flow White', 'price': 150, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Corsair 4000D Airflow', 'price': 105, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Fractal Design North Walnut', 'price': 140, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Phanteks NV7 Black', 'price': 220, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Hyte Y60 Panoramic Gg', 'price': 200, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Montech SKY TWO Black', 'price': 95, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'be quiet! Shadow Base 800', 'price': 170, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Thermaltake Ceres 500', 'price': 130, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Cooler Master TD500 Mesh V2', 'price': 100, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'NZXT H6 Flow RGB Black', 'price': 134, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Lian Li Lancool 216 RGB', 'price': 99, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Fractal Design Terra Jade Mini', 'price': 179, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Phanteks Eclipse G360A', 'price': 89, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Corsair iCUE Link 3500X RGB', 'price': 149, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'ASUS ROG Strix Helios', 'price': 299, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
    {'name': 'Deepcool CH560 Digital Black', 'price': 109, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Montech AIR 903 Max', 'price': 79, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Antec Performance 1 FT', 'price': 159, 'category': 'Case', 'imageUrl': imgCase, 'rating': 4},
    {'name': 'Cougar Conquer Cyber Case', 'price': 349, 'category': 'Case', 'imageUrl': imgCase, 'rating': 5},
  ];

  static List<Map<String, dynamic>> get cpus {
    _ensureInitialized();
    return _cpus;
  }

  static List<Map<String, dynamic>> get motherboards {
    _ensureInitialized();
    return _motherboards;
  }

  static List<Map<String, dynamic>> get rams {
    _ensureInitialized();
    return _rams;
  }

  static List<Map<String, dynamic>> get gpus {
    _ensureInitialized();
    return _gpus;
  }

  static List<Map<String, dynamic>> get storages {
    _ensureInitialized();
    return _storages;
  }

  static List<Map<String, dynamic>> get psus {
    _ensureInitialized();
    return _psus;
  }

  static List<Map<String, dynamic>> get cases {
    _ensureInitialized();
    return _cases;
  }

  static List<Map<String, dynamic>> get allProducts {
    return [
      ...cpus,
      ...motherboards,
      ...rams,
      ...gpus,
      ...storages,
      ...psus,
      ...cases,
    ];
  }

  static bool _initialized = false;

  static void _ensureInitialized() {
    if (_initialized) return;
    _initialized = true;

    for (var item in _cpus) {
      item['imageUrl'] = _getCpuImage(item['name'] as String);
    }
    for (var item in _motherboards) {
      item['imageUrl'] = _getMoboImage(item['name'] as String);
    }
    for (var item in _rams) {
      item['imageUrl'] = _getRamImage(item['name'] as String);
    }
    for (var item in _gpus) {
      item['imageUrl'] = _getGpuImage(item['name'] as String);
    }
    for (var item in _storages) {
      item['imageUrl'] = _getStorageImage(item['name'] as String);
    }
    for (var item in _psus) {
      item['imageUrl'] = _getPsuImage(item['name'] as String);
    }
    for (var item in _cases) {
      item['imageUrl'] = _getCaseImage(item['name'] as String);
    }
  }

  static String _getCpuImage(String name) {
    if (name.toLowerCase().contains('ryzen') || name.toLowerCase().contains('amd')) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHMNZjbSIorUX9H14KO8GRrbvsI4797sKllmSfPI_hevDgcPISpVuZ5BM&s=10';
    } else {
      return 'https://preview.redd.it/does-anybody-else-miss-the-design-of-the-cpu-boxes-we-got-v0-bo1qrpa271i81.jpg?width=800&format=pjpg&auto=webp&s=b12e05b3ee668d9dba44d1e6fda0f5aed76bcada';
    }
  }

  static String _getMoboImage(String name) =>
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg5f9eaLD6-RiZUuOFTsXoIE1hdM2Tb04UOkdNPX6VgVBf1Z7Hzxw41o16&s=10';

  static String _getRamImage(String name) =>
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEF9Dit6kQkhucb8R-eQ2qWmZ_aOItm2LR6yBYRVpTsx77yRCHFB540k1N&s=10';

  static String _getGpuImage(String name) =>
      'https://i.ebayimg.com/images/g/VmsAAOSwfrlnx8pF/s-l400.jpg';

  static String _getStorageImage(String name) =>
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU274yVum1QqcAortlmLHIO6EWcELFa3vx9iayO3f8uQ&s=10';

  static String _getPsuImage(String name) =>
      'https://c8.alamy.com/comp/G29229/pc-power-supply-isolated-G29229.jpg';

  static String _getCaseImage(String name) =>
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1658EwibLcEZYgNBeY5OoVW1-hyDyDifVz4r3IMCTNlqaTumyqazJbe43&s=10';
}
