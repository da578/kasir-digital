fn main() {
	barang_barang := barang_tersedia()
	tampilkan_menu(barang_barang)

	keranjang, total_belanja, total_item := proses_pembelian(barang_barang) or {
		if err.str() == 'exit' {
			println('Terima kasih telah menggunakan program ini.')
			return
		} else {
			println('Terjadi kesalahan tidak terduga dalam pembelian.')
			return
		}
	}

	if total_item == 0 {
		println('Tidak ada barang yang dibeli. Terima kasih!')
		return
	}

	uang_pembayaran := proses_pembayaran(total_belanja) or { return }

	tampilkan_struk_pembayaran(StrukPembayaran{
		barang_barang_yang_dibeli: keranjang
		total_item:                total_item
		total_belanja:             total_belanja
		uang_pembayaran:           uang_pembayaran
		kembalian:                 uang_pembayaran - total_belanja
	})
}
