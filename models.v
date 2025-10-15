module main

struct Barang {
	nama  string @[required]
	harga u32    @[required]
}

struct BarangYangDibeli {
	nama      string @[required]
	harga     u32    @[required]
	kuantitas u32    @[required]
	subtotal  u32    @[required]
}

struct StrukPembayaran {
	barang_barang_yang_dibeli []BarangYangDibeli @[required]
	total_item                u32                @[required]
	total_belanja             u32                @[required]
	uang_pembayaran           u32                @[required]
	kembalian                 u32                @[required]
}

fn barang_tersedia() []Barang {
	return [
		Barang{
			nama:  'Roti Tawar'
			harga: 8_000
		},
		Barang{
			nama:  'Susu UHT'
			harga: 5_500
		},
		Barang{
			nama:  'Sabun Mandi'
			harga: 4_000
		},
		Barang{
			nama:  'Shampoo 100ml'
			harga: 12_000
		},
		Barang{
			nama:  'Air Mineral 600ml'
			harga: 3_000
		},
	]
}
