# Membuat omnivoice-tts.exe

Program ini tidak punya versi siap pakai (repo-nya tidak punya Releases), jadi harus dibangun dari kode sumber (MIT). Pilih SATU cara:

## Cara A: GitHub Actions (tanpa memasang apa pun di PC)
1. Buat akun GitHub gratis, lalu repositori baru (boleh privat).
2. Unggah folder `.github` dari folder ini ke repositori itu (tarik dan lepas di halaman repositori).
3. Buka tab **Actions**, pilih **build-omnivoice-tts**, klik **Run workflow**.
4. Setelah selesai (sekitar 10-20 menit), unduh artifact `omnivoice-tts-windows-cpu`, ekstrak, lalu salin semua isinya ke folder `bin` di proyek VoiceStudio-Local.

## Cara B: bangun di PC sendiri
Pasang Git, CMake, dan Visual Studio Build Tools 2022 (beban kerja C++, beberapa GB), lalu jalankan `build-omnivoice.bat`. Hasilnya otomatis disalin ke folder `bin`.

Catatan: kedua cara belum saya uji karena sandbox saya tidak punya akses ke sana. Kalau gagal, kirim pesan errornya. Build CPU sudah cukup; GPU Vulkan opsional (`build-omnivoice.bat vulkan`, butuh Vulkan SDK) dan belum tentu lebih cepat di GPU terintegrasi.
