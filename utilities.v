module main

import os
import strconv

fn input_u32(prompt string) !u32 {
	for {
		str := os.input(prompt)
		return strconv.atou32(str) or {
			error('Input harus berupa angka positif. Coba lagi.')
			continue
		}
	}

	return 0
}

fn tampilkan_menu(barang_barang []Barang) {
	println('=============================================')
	println('SELAMAT DATANG DI ITERA MART')
	println('=============================================')
	println('0. Selesai belanja')
	for i, barang in barang_barang {
		println('${i + 1}. ${barang.nama:-20} - Rp${barang.harga}')
	}
	println('6. Keluar')
	println('=============================================')
}

fn tampilkan_struk_pembayaran(struk StrukPembayaran) {
	println('=============================================')
	println('           STRUK PEMBAYARAN')
	println('=============================================')
	println('Barang               Qty   Harga     Subtotal')
	println('---------------------------------------------')

	for barang in struk.barang_barang_yang_dibeli {
		println('${barang.nama:-20} ${barang.kuantitas:3}   Rp${barang.harga:5}   Rp${barang.subtotal:7}')
	}

	println('---------------------------------------------')
	println('Total Item           : ${struk.total_item}')
	println('Total Belanja        : Rp${struk.total_belanja}')
	println('Uang Pembayaran      : Rp${struk.uang_pembayaran}')
	println('Kembalian            : Rp${struk.kembalian}')
	println('\n=============================================')
	println('   TERIMA KASIH TELAH BERBELANJA!')
	println('         DI ITERA MART')
	println('=============================================')
}

fn proses_pembelian(barang_barang []Barang) !([]BarangYangDibeli, u32, u32) {
	mut keranjang := []BarangYangDibeli{}
	mut total_belanja := u32(0)
	mut total_item := u32(0)

	for {
		pilihan := input_u32('\nMasukkan pilihan (0-6): ') or { continue }

		match pilihan {
			0 {
				break
			}
			6 {
				return error('exit')
			}
			1, 2, 3, 4, 5 {
				if pilihan > u32(barang_barang.len) {
					println('Pilihan tidak valid.')
					continue
				}

				barang := barang_barang[pilihan - 1]

				kuantitas := input_u32('Masukkan jumlah barang: ') or { continue }
				if kuantitas == 0 {
					println('Kuantitas minimal 1.')
					continue
				}

				subtotal := kuantitas * barang.harga

				println('Anda memilih : ${barang.nama} - Rp${barang.harga}')
				println('Subtotal     : Rp${subtotal}')

				keranjang << BarangYangDibeli{
					nama:      barang.nama
					harga:     barang.harga
					kuantitas: kuantitas
					subtotal:  subtotal
				}
				total_belanja += subtotal
				total_item += kuantitas
			}
			else {
				println('Pilihan tidak ada dalam daftar.')
				continue
			}
		}
	}

	return keranjang, total_belanja, total_item
}

fn proses_pembayaran(total_belanja u32) ?u32 {
	println('\n-----------------------------------')
	println('TOTAL BELANJA: Rp${total_belanja}')
	println('-----------------------------------')

	for {
		uang := input_u32('\nMasukkan jumlah uang yang dibayar: ') or { continue }
		if uang < total_belanja {
			println('Uang kurang! Total: Rp${total_belanja}. Silakan masukkan lebih banyak.')
			continue
		}
		return uang
	}

	return none
}
